#!/usr/bin/env rake

task default: %w[all_tests]

task :all_tests do
  require 'rspec/core/rake_task'
  ENV['RAILS_ENV'] = 'test'
  ENV['USE_TURNIP'] = 'true'

  RSpec::Core::RakeTask.new(:turnip) do |t|
    t.rspec_opts = "--tag ~@wip -r turnip/rspec --format documentation"
    t.pattern    = 'spec/feature/**/*.feature'
  end
  Rake::Task['turnip'].execute
end
