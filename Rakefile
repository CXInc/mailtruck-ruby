require "bundler/gem_tasks"

require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs << 'spec'
  t.pattern = "spec/lib/*_spec.rb"
  # t.verbose = true
end
