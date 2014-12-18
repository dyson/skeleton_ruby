module SkeletonRuby
  module Database

    def self.initialize
      # Set up active record Logger, load configuration and set database based on environment
      ActiveRecord::Base.logger = SkeletonRuby::Logger

      configuration_dir = File.expand_path '../../../config', __FILE__
      database_configuration = YAML.load File.read(File.join(configuration_dir, 'database.yml'))

      ActiveRecord::Base.configurations = database_configuration
      ActiveRecord::Base.establish_connection ENV['APP_ENV'].to_sym
    end

  end
end
