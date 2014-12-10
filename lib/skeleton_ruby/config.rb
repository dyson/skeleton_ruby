require 'ostruct'

module SkeletonRuby
  module Config

    def self.config
      @@config ||= OpenStruct.new
    end

    def self.configure
      yield(config) if block_given?
    end

  end
end
