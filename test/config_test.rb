require_relative 'test_helper'

class ConfigTest < ActiveSupport::TestCase
  test 'config' do
    SkeletonRuby::Config.configure do |configuration|
      configuration.letter = 'a'
      configuration.number = '1'
      configuration.color = 'blue'
    end

    assert (
      SkeletonRuby::Config.letter == 'a' and
      SkeletonRuby::Config.number == '1' and
      SkeletonRuby::Config.color == 'blue'
    )
  end
end
