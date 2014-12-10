require 'fileutils'
require 'logger'

module SkeletonRuby
  module Logger

    @@log_path = File.expand_path "../../../log/#{ENV['APP_ENV']}.log", __FILE__

    def self.log
      @@logger ||= create
    end

    def self.log_path
      @@log_path
    end

    private
      def self.create
        FileUtils.touch log_path
        ::Logger.new log_path
      end

  end
end
