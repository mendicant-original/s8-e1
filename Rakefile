task :default => :check

task :check => [:spec, :test]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test do
  tests = %w[tc_z tc_z_basic]
  tests.each { |test|
    puts "== Running test #{test}:"
    ruby '-W0', "tests_from_gmp_gem/#{test}.rb"
  }
end
