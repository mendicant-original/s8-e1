task :default => :check

task :check => [:spec, :test]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test do
  ruby 'tests_from_gmp_gem/tc_z.rb'
end
