# Require active record
require 'bundler/setup'
require 'active_record'

include ActiveRecord::Tasks

# Paths
root_dir = Rake.application.original_dir
db_dir = File.join(root_dir, 'db')
config_dir = File.join(root_dir, 'config')

# Set configuration used in load_config task which is a prerequisite for some of the db tasks
ActiveRecord::Tasks::DatabaseTasks.tap do |config|
  config.root = root_dir
  config.env = ENV['APP_ENV'] || 'development'
  config.db_dir = db_dir
  config.migrations_paths = File.join(db_dir, 'migrate')
  config.database_configuration = YAML.load(File.read(File.join(config_dir, 'database.yml')))
end

# Set environment task which is a prerequisite for some of the db tasks
namespace :db do
  task :environment do
    ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
    ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
  end
end

# Load the tasks
load 'active_record/railties/databases.rake'
