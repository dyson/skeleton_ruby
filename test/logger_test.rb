require_relative 'test_helper'

class LoggerTest < ActiveSupport::TestCase
  test 'logger' do
    log_message = 'Test log message'
    SkeletonRuby::Logger.info log_message

    last_log_message = `tail -1 #{SkeletonRuby::Logger.log_path}`

    assert last_log_message.split(' ')[-3..-1].join(' ') == log_message
  end
end
