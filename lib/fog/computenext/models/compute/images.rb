require 'fog/core/collection'
require 'fog/computenext/models/compute/image'

module Fog
  module Compute
    class Computenext

      class Images < Fog::Collection

        model Fog::Compute::Computenext::Image

        attribute :server

        def all
          data = service.get_resourcetype_detail('image').body
          load(data)
          if server
            self.replace(self.select {|image| image.server_id == server.id})
          end
        end

        def get(image_id)
          data = service.get_resourcetype_detail('image/#image_id').body
          new(data)
        rescue Fog::Compute::Computenext::NotFound
          nil
        end

      end

    end
  end
end
