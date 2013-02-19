
module Fog
  module Compute
    class Computenext
      class Real

        def get_metadata
          request(
            :expects  => [200, 203],
            :method   => 'GET',
            :path     => "resourceQuery/metadata"
          )
        end
        
      end

      class Mock
        def get_metadata
          response = Excon::Response.new
          response.status = 200
          response.headers = {
            "Content-Length" => "360",
	    "Cache-Control" => "private",
            "Content-Type" => "application/json",
            "Date" => Date.new}
          response.body = [
  		{
    		"id" => "image",
    		"description" => "Image",
    		"filters" => [
      			{
        		"id" => "location",
        		"description" => "Location",
        		"options" => [
          			{
            			"id" => "location_Amsterdam, Netherlands",
            			"description" => "Amsterdam, Netherlands",
            			"value" => "Amsterdam, Netherlands"
          			}]}
		]}]
         response
        end
      end # mock
    end # computenext
  end # compute
end # fog
