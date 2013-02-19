require 'fog/core/collection'
require 'fog/computenext/models/compute/workload'

module Fog
  module Compute
    class Computenext

      class Workloads < Fog::Collection

        model Fog::Compute::Computenext::Workload

        def all
          data = service.get_current_workload.body
          load(data)
        end

        def get
          data = service.get_current_workload_detail.body
          new(data)
        rescue Fog::Compute::Computenext::NotFound
          nil
        end

      end

    end
  end
end
