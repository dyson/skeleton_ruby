desc "Open an irb session preloaded with SkeletonRuby"
task :console, :app_env  do |t, args|
  app_env = args.app_env ? args.app_env : 'development'
  sh "APP_ENV=#{app_env} sh -c 'irb -rubygems -I lib -r skeleton_ruby.rb'"
end
