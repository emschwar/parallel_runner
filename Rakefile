require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rdoc/task"

RDoc::Task.new

RSpec::Core::RakeTask.new(:test)

task :default => [:test, :build]