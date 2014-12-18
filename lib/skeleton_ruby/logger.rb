require 'fileutils'
require 'logger'

module SkeletonRuby
  module Logger
    class << self

      # Log path is only here for the example logger_test.
      @@log_path = File.expand_path "../../../log/#{ENV['APP_ENV']}.log", __FILE__

      def log_path
        @@log_path
      end

      def create stdout = false, log_level = :error
        if stdout
          @@log = ::Logger.new STDOUT
        else
          FileUtils.touch log_path
          @@log = ::Logger.new log_path
        end

        @@log.level = ::Logger.const_get log_level.to_s.upcase
      end

      def self.respond_to_missing?(method, include_private_methods = false)
        create if not defined? @@log
        @@log.respond_to?(method) || super
      end

      private

        def method_missing(name, *args, &block)
          create if not defined? @@log
          @@log.send(name, *args, &block)
        end

    end
  end
end
