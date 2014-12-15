require 'ostruct'

module SkeletonRuby
  module Config

    def self.configure
      yield(config) if block_given?
    end

    def self.inspect
      config.inspect
    end

    def self.method_missing(method, *args, &block)
      config.send(method, *args, &block)
    end

    def self.respond_to_missing?(method, include_private_methods = false)
      config.respond_to?(method) || super
    end

    private
      def self.config
        @@config ||= OpenStruct.new
      end

  end
end
