task :default => :check

task :check => [:spec, :test]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec => :build)

task :test do
  tests = %w[tc_z tc_z_basic tc_fib_fac_nextprime]
  tests.each { |test|
    puts "== Running test #{test}:"
    ruby '-W0', "tests_from_gmp_gem/#{test}.rb"
  }
end

task :build => 'ext/Makefile' do
  Dir.chdir('ext') { sh 'make' }
end

file 'ext/Makefile' => 'ext/extconf.rb' do
  Dir.chdir('ext') { ruby 'extconf.rb' }
end

task :bench do
  Dir['bench/*.rb'].each { |bench|
    ruby '-W0', bench
  }
end
