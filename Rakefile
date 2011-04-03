task :default => :check

task :check => [:spec, :test]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec => :build)

task :test do
  path = lambda { |test| "tests_from_gmp_gem/#{test}.rb" }
  tests = %w[
    tc_zerodivisionexceptions tc_cmp tc_constants tc_floor_ceil_truncate tc_sgn_neg_abs tc_swap
  ]
  tests = tests.map { |test| path[test] }
  tests |= Dir[path['tc_{z,q}*']]
  tests.delete path['tc_z_functional_mappings']
  tests.delete path['tc_z_to_dis']
  require 'test/unit'
  runner = Test::Unit::AutoRunner.new(true)
  runner.process_args(tests)
  runner.run
end

task :build => ['ext/Makefile', 'ffi/functions.yml'] do
  Dir.chdir('ext') { sh 'make' }
end

file 'ext/Makefile' => 'ext/extconf.rb' do
  Dir.chdir('ext') { ruby 'extconf.rb' }
end

file 'ffi/functions.yml' => ['ffi/generate.rb', 'ffi/gmp.preprocessed.h'] do
  ruby 'ffi/generate.rb'
end

task :bench do
  Dir['bench/*.rb'].each { |bench|
    ruby '-W0', bench
  }
end
