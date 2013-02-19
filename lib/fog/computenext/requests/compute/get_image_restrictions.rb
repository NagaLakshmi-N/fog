
module Fog
  module Compute
    class Computenext
      class Real

        def get_image_restrictions(imageId)
          request(
            :expects  => [200, 203],
            :method   => 'GET',
            :path     => "resourceQuery/restrictions/#{imageId}"
          )
        end
        
      end

      class Mock
        def get_current_workload
          response = Excon::Response.new
          response.status = 200
          response.headers = {
            "Content-Length" => "360",
	    "Cache-Control" => "private",
            "Content-Type" => "application/json",
            "Date" => Date.new}
          response.body = {
            	 "WorkloadId" => "8cd6f28a-6979-48fa-a9ba-820106280cb1",
 		 "WorkloadName" => "My Workload 3",
 		 "NumberOfResourcesInWorkload" => "9",
 		 "WorkloadElementDetail" => []
		}
         response
        end
      end # mock
    end # computenext
  end # compute
end # fog
