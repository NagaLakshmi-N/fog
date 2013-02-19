require 'fog/core/collection'
require 'fog/computenext/models/compute/key_pair'

module Fog
  module Compute
    class Computenext

      class KeyPairs < Fog::Collection

        model Fog::Compute::Computenext::KeyPair

        def all
          items = Array.new
          service.list_key_pairs.body['keypairs'].each do |kp|
            items = items + kp.values
          end
          load(items)
	def get(key_pair_name)
          if key_pair_name
            self.all.select {|kp| kp.name == key_pair_name}.first
          end
        rescue Fog::Compute::Computenext::NotFound
          nil
        end
        end
      end
    end
  end
end
