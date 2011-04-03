task :default => :check

task :check => [:spec, :test]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec => :build)

task :test do
  tests = %w[
    tc_z tc_z_basic tc_fib_fac_nextprime tc_hashes tc_logical_roots tc_z_exponentiation
    tc_z_gcd_lcm_invert tc_z_logic tc_z_shifts_last_bits tc_z_jac_leg_rem tc_z_addmul
    tc_z_submul
    tc_q tc_q_basic
    tc_zerodivisionexceptions tc_cmp tc_constants
  ]
  tests = tests.map { |test| "tests_from_gmp_gem/#{test}.rb" }
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
