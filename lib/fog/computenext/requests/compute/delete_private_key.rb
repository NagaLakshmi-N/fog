module Fog
  module Compute
    class Computenext
      class Real

        def delete_private_key(keypair_id)
          request(
            :expects  => [200, 203],
            :method   => 'PUT',
            :path     => "keypairs/#{keypair_id}"
          )
        end

      end

      class Mock
        def delete_private_key(keypair_id)
          response = Excon::Response.new
          response.status = 200
          response.headers = {
            "Content-Length" => "360",
	    "Cache-Control" => "private",
            "Content-Type" => "application/json",
            "Date" => Date.new}
          response.body ={
  		"KeyPairId" => "283b6df2-461e-4ad8-9ad4-e7883e25821f"
		}
          response
        end
      end # mock
    end # Computenext
  end # compute
end # fog
