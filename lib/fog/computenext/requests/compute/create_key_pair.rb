module Fog
  module Compute
    class Computenext
      class Real	
	def create_key_pair(name, provider_id, region)

          data = {
              'Name' => name,
	      'ProviderId' => provider_id,
	      'Region' => region
            }
                  
          request(
            :body     => MultiJson.encode(data),
            :expects  => 200,
            :method   => 'POST',
            :path     => 'keypairs?format=json'
          )
        end

      end

      class Mock
        def create_key_pair(name, provider_id, region)
          response = Excon::Response.new
          response.status = 200
          response.headers = {
            "Content-Length" => "360",
	    "Cache-Control" => "private",
            "Content-Type" => "application/json",
            "Date" => Date.new}
          response.body = {
             "KeyPairId" => "b5441c60-5492-4c83-b0e9-3b37befed977"
          }
          response
        end
      end # mock
    end # computenext
  end # compute
end # fog
