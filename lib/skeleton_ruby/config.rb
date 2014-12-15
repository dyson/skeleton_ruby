require 'ostruct'

module SkeletonRuby
  module Config

    def self.configure
      yield(config) if block_given?
    end

    def self.method_missing(method, *args, &block)
      config.send(method, *args, &block)
    end

    private
      def self.config
        @@config ||= OpenStruct.new
      end

  end
end
