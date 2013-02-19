require 'fog/core/model'
require 'fog/computenext/models/compute'

module Fog
  module Compute
    class Computenext

      class Image < Fog::Model

        identity :id

        attribute :name
        attribute :region
        attribute :platform
        attribute :provider
        attribute :shortdescription


        def initialize(attributes)
          # Old 'connection' is renamed as service and should be used instead
          prepare_service_value(attributes)
          super
        end

        def metadata
          @metadata ||= begin
            Fog::Compute::Computenext::Metadata.new({
              :service => service,
              :parent => self
            })
          end
        end

        def metadata=(new_metadata={})
          metas = []
          new_metadata.each_pair {|k,v| metas << {"key" => k, "value" => v} }
          metadata.load(metas)
        end

        def destroy
          requires :id
          service.delete_image(id)
          true
        end

        def ready?
          status == 'ACTIVE'
        end

      end

    end
  end
end
