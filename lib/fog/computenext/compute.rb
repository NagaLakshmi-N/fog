require 'fog/compute'
require 'fog/computenext'

module Fog
  module Compute
    class Computenext < Fog::Service
	  requires :computenext_auth_url
	  recognizes :computenext_access_key, :computenext_secret_key, :name
      ## MODELS
      #
      model_path 'fog/computenext/models/compute'
      model	  :key_pair
      collection  :key_pairs
      model	  :workload
      collection  :workloads
      model	  :resource
      collection  :resources      

      #REQUESTS
      request_path 'fog/computenext/requests/compute'

      # Key Pair
      request	  :list_key_pairs
      request	  :get_key_pair
      request	  :create_key_pair
      request	  :delete_private_key

      #Workloads
      request	  :get_current_workload
      request	  :get_current_workload_detail

      #Resources
      request	  :get_metadata
      request	  :get_resourcetype_detail
      request	  :list_regions

      #Security Groups
      request	  :list_security_groups
      request	  :create_security_group
      
      class Mock
        
        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {
              :last_modified => {
                :images  => {},
                :servers => {},
                :key_pairs => {},
                :security_groups => {},
                :addresses => {}
              },
              :images  => {
                "0e09fbd6-43c5-448a-83e9-0d3d05f9747e" => {
                  "id"=>"0e09fbd6-43c5-448a-83e9-0d3d05f9747e",
                  "name"=>"cirros-0.3.0-x86_64-blank",
                  'progress'  => 100,
                  'status'    => "ACTIVE",
                  'updated'   => "",
                  'minRam'    => 0,
                  'minDisk'   => 0,
                  'metadata'  => {},
                  'links'     => [{"href"=>"http://nova1:8774/v1.1/admin/images/1", "rel"=>"self"}, {"href"=>"http://nova1:8774/admin/images/2", "rel"=>"bookmark"}]
                }
              },
              :servers => {},
              :key_pairs => {},
              :security_groups => {
                0 => {
                  "id"          => 0,
                  "tenant_id"   => Fog::Mock.random_hex(8),
                  "name"        => "default",
                  "description" => "default",
                  "rules"       => [
                    { "id"              => 0,
                      "parent_group_id" => 0,
                      "from_port"       => 68,
                      "to_port"         => 68,
                      "ip_protocol"     => "udp",
                      "ip_range"        => { "cidr" => "0.0.0.0/0" },
                      "group"           => {}, },
                  ],
                },
              },
              :server_security_group_map => {},
              :addresses => {},
              :quota => {
                'security_group_rules' => 20,
                'security_groups' => 10,
                'injected_file_content_bytes' => 10240,
                'injected_file_path_bytes' => 256,
                'injected_files' => 5,
                'metadata_items' => 128,
                'floating_ips'   => 10,
                'instances'      => 10,
                'key_pairs'      => 10,
                'gigabytes'      => 5000,
                'volumes'        => 10,
                'cores'          => 20,
                'ram'            => 51200
              }
            }
          end
        end

        def self.reset
          @data = nil
        end
        def initialize(options={})
          @computenext_access_key = options[:computenext_access_key]
          @computenext_secret_key = options[:computenext_secret_key]	
          @computenext_auth_url = URI.parse(options[:computenext_auth_url])
	  @computenext_management_url = options[:computenext_management_url]
        end
	def credentials
          { 
	    :provider                 => 'computenext',
            :computenext_auth_url       => @computenext_auth_uri.to_s,
            :computenext_acces_key     => @computenext_access_key,
            :computenext_secret_key => @computenext_secret_key }
        end
      end

      class Real
        def initialize(options={})
	  @computenext_username = options[:computenext_access_key]
          @computenext_password = options[:computenext_secret_key]
	  @computenext_auth_uri = URI.parse(options[:computenext_auth_url])
          management_url = URI.parse(options[:computenext_auth_url])
          management_url.user = @computenext_username
          management_url.password = @computenext_password
          @computenext_management_url = management_url.to_s

          @computenext_service_type = options[:computenext_service_type] || ['nova', 'compute']
          @computenext_service_name = options[:computenext_service_name]
          @computenext_must_reauthenticate  = false
	  @connection_options = options[:connection_options] || {}
          uri = URI.parse(@computenext_management_url)
          @host   = uri.host
          @path	  = uri.path
          @port   = uri.port
          @scheme = uri.scheme
	  @persistent = options[:persistent] || false
	  @connection = Fog::Connection.new(@computenext_management_url, @persistent, @connection_options)
	end
	def credentials
          { 
	    :provider          	 	=> 'computenext',
            :computenext_auth_url       => @computenext_auth_uri.to_s,
	    :computenext_management_url => @computenext_management_url,
            :computenext_acces_key 	=> @computenext_access_key,
            :computenext_secret_key 	=> @computenext_secret_key }
        end

        def reload
          @connection.reset
        end

        def request(params)
          begin

            response = @connection.request(params.merge({
              :headers  => {
                  'Accept' => 'application/json',
		  'Content-Type' => 'application/json'}.merge!(params[:headers] || {}),
	      :host     => @host,
              :path     => "#{@path}/#{params[:path]}?format=json",
              :query    => params[:query]
            }))
		#puts params
		puts "Connection Established"
		#puts response.body

          rescue Excon::Errors::Unauthorized => error
            if error.response.body != 'Bad username or password' # token expiration
              retry
            else # Bad Credentials
              raise error
            end
          rescue Excon::Errors::HTTPStatusError => error
            raise case error
              when Excon::Errors::NotFound
			puts "Connection Error"
                Fog::Compute::Computenext::NotFound.slurp(error)
              else
                error
              end
	   
          end

          unless response.body.empty?
            response.body = Fog::JSON.decode(response.body)
          end
         #puts message = response.body[0]['zone']
	response
        end

      end
    end
  end
end

	
