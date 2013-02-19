
module Fog
  module Compute
    class Computenext
      class Real

        def get_security_group(security_group_id)
          request(
            :expects  => [200, 203],
            :method   => 'GET',
            :path     => "securitygroups/#{security_group_id}"
          )
        end
        
      end

      class Mock
        def get_security_group(security_group_id)
          response = Excon::Response.new
          response.status = 200
          response.headers = {
            "Content-Length" => "360",
	    "Cache-Control" => "private",
            "Content-Type" => "application/json",
            "Date" => Date.new}
          response.body = {
  		"SecurityGroupId" => "9b459ad8-bd93-47b9-bd97-9385126213c4",
		"ProviderId" => "80298397254d469cb319996fb1b05936",
  		"ProviderName" => "HPCloud",
  		"ExternalId" => "ec151580-27f4-467a-8115-378839706f1a_SG1",
  		"Region" => "nova",
  		"Name" => "SG1",
  		"Description" => "Sec Grp",
  		"Ports" => [
    			{
      			"Protocol" => "TCP",
      			"FromPort" => "80",
      			"ToPort" => "80",
      			"IpAddress" => "0.0.0.0/0"
    			}
 			 ],
  		"StatusCode" => "Created"
		}80298397254d469cb319996fb1b05936
         response
        end
      end # mock
    end # computenext
  end # compute
end # fog
