
module Fog
  module Compute
    class Computenext
      class Real

        def get_resourcetype_detail(resource_type)
          request(
            :expects  => [200, 203],
            :method   => 'GET',
            :path     => "resourceQuery/query/#{resource_type}/"
          )
        end
        
      end

      class Mock
        def get_resourcetype_detail(resource_type)
          response = Excon::Response.new
          response.status = 200
          response.headers = {
            "Content-Length" => "360",
	    "Cache-Control" => "private",
            "Content-Type" => "application/json",
            "Date" => Date.new}
          response.body =[
  		{
    		"zone" => "nova",
    		"tier" => "3",
    		"software" => [
      		"CentOS 6.2"
    			],
    		"slaSummary" => " ",
    		"platform" => "Openstack",
    		"numberOfNines" => "4",
    		"location" => "Las Vegas, Nevada",
    		"connectorType" => "ComputeNext.CloudFederation.ProviderGateway.HPCloud.HPCloudProvider",
    		"Benefits" => " ",
    		"costUnit" => "per hour",
    		"description" => "CentOS 6.2 Server 64-bit",
    		"DetailedDescription" => " ",
    		"id" => "97e3f0f2-2951-4b3f-a808-4496e7d003d4",
    		"isAvailable" => "1",
    		"name" => "CentOS 6.2 Server 64-bit",
    		"operatingSystemType" => "Linux",
    		"operatingSystemVersion" => "64 Bit",
   		"provider" => "HPCloud",
    		"providerResourceId" => "ami-00000071",
    		"rank" => "0025435a00a94d1f5e8f378e3ca8390f",
    		"region" => "nova",
   		"ShortDescription" => "<p><strong>Minimum System Requirements:</strong></p><p>CPU Count: 1 RAM: 1GB Storage: 10GB</p>"
  		}]
         response
        end
      end # mock
    end # computenext
  end # compute
end # fog
