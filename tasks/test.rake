desc "Run tests"
task :test do
  Rake::TestTask.new do |t|
    t.test_files = Dir.glob('test/**/*_test.rb')
  end
end
