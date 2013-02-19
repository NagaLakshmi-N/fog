
module Fog
  module Compute
    class Computenext
      class Real

        def get_current_workload_detail
          request(
            :expects  => [200, 203],
            :method   => 'GET',
	    #:query => 'format=json',
            :path     => "workloads/getcurrentdetail"
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
		"NumberOfResourcesInWorkload" => "1",
		"WorkloadElementDetail" => [{
			"WorkloadElementId" => "fb735b07-7dfb-41f8-b958-7143457443f3",
			"WorkloadElementName" => "HPCloud 2X Large VM with Fedora 16 Server 64 Bit",
			"Price" => "1.320000","Unit" => "per hour"}]
			 }

         response
        end
      end # mock
    end # computenext
  end # compute
end # fog
