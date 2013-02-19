module Fog
  module Compute
    class Computenext
      class Real

        def get_key_pair(keypair_id)
          request(
            :expects  => [200, 203],
            :method   => 'GET',
            :path     => "keypairs/#{keypair_id}"
          )
        end

      end

      class Mock
        def get_key_pair(keypair_id)
          response = Excon::Response.new
          response.status = 200
          response.headers = {
            "Content-Length" => "360",
	    "Cache-Control" => "private",
            "Content-Type" => "application/json",
            "Date" => Date.new}
          response.body =[{
		"CnId" => "9cc66ea6ff3e4dcba87442b36bb976fe",
		"ProviderId" => "de371444703a4bb5b3ab3f9f9ca45996",
		"ProviderName" => "BitRefinery",
		"Region" => "computenext","Name" => "MyKeyPair"}]

          response
        end
      end # mock
    end # Computenext
  end # compute
end # fog
