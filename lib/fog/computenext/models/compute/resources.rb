require 'fog/core/collection'
require 'fog/computenext/models/compute/resource'

module Fog
  module Compute
    class Computenext

      class Resources < Fog::Collection

        model Fog::Compute::Computenext::Resource

        def all
          data = service.get_metadata.body
          load(data)
        end

        def get(resource_type)
          data = service.get_resourcetype_detail.body
          new(data)
        rescue Fog::Compute::Computenext::NotFound
          nil
        end

      end

    end
  end
end
