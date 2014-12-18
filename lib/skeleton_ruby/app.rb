module SkeletonRuby
  class App

    def initialize
    end

    def run
      # Access configruation
      puts SkeletonRuby::Config.something

      # Log something
      SkeletonRuby::Logger.info "Log this!"

      puts 'Running application'

      # Interact with database
      user = User.new
      user.name = 'Test'
      if user.save
        puts 'User Saved'
      end

    end

  end
end
