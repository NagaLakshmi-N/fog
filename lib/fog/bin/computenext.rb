class Computenext < Fog::Bin
  class << self

    def class_for(key)
      case key
      when :compute
        Fog::Compute::Computenext
      when :identity
        Fog::Identity::Computenext
      when :network
        Fog::Network::Computenext
      else
        raise ArgumentError, "Unrecognized service: #{key}"
      end
    end

    def [](service)
      @@connections ||= Hash.new do |hash, key|
        hash[key] = case key
        when :compute
          Fog::Logger.warning("Computenext[:compute] is not recommended, use Compute[:computenext] for portability")
          Fog::Compute.new(:provider => 'Computenext')
        when :identity
          Fog::Logger.warning("Computenext[:identity] is not recommended, use Compute[:computenext] for portability")
          Fog::Compute.new(:provider => 'Computenext')
        when :network
          Fog::Logger.warning("Computenext[:network] is not recommended, use Network[:computenext] for portability")
          Fog::Network.new(:provider => 'Computenext')
        else
          raise ArgumentError, "Unrecognized service: #{key.inspect}"
        end
      end
      @@connections[service]
    end

    def services
      Fog::Computenext.services
    end

  end
end
