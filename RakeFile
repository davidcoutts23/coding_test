# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[lint test]

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end

task :run do
  ruby 'lib/robot_challenge.rb'
end

task :test do
  bundle exec 'rspec -fd'
end

task :integration_test do
  bundle exec 'rspec -fd  spec/integration_test.rb'
end
