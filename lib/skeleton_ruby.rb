# Bundler
require 'bundler/setup'

# Set environment
ENV['APP_ENV'] ||= 'development'

# Autoload gems for the environment
Bundler.require(:default, ENV['APP_ENV'])

# Require mixins and classes
require_relative 'skeleton_ruby/app'
require_relative 'skeleton_ruby/config'
require_relative 'skeleton_ruby/database'
require_relative 'skeleton_ruby/logger'

# Require config
require_relative '../config/application'

# Require model
require_relative 'skeleton_ruby/models/user'

SkeletonRuby::Database.initialize

module SkeletonRuby
end
