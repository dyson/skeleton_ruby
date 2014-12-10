require_relative 'test_helper'

class ConfigTest < ActiveSupport::TestCase
  test 'config' do
    SkeletonRuby::Config.configure do |configuration|
      configuration.letter = 'a'
      configuration.number = '1'
      configuration.color = 'blue'
    end

    assert (
      SkeletonRuby::Config.config.letter == 'a' and
      SkeletonRuby::Config.config.number == '1' and
      SkeletonRuby::Config.config.color == 'blue'
    )
  end
end
