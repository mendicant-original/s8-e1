task :default => :check

task :check => [:spec, :test]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec => :build)

task :test do
  path = lambda { |test| "tests_from_gmp_gem/#{test}.rb" }
  tests = Dir[path['*']].reject { |test|
    File.read(test) =~ /\bGMP::(?:F|RandState)\b|MPFR/
  }
  tests.delete path['tc_z_functional_mappings']

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

file 'ffi/functions.yml' => 'ffi/gmp.preprocessed.h'

file 'ffi/gmp.preprocessed.h' => 'ffi/generate.rb' do
  ruby 'ffi/generate.rb'
end

task :bench do
  Dir['bench/*.rb'].each { |bench|
    ruby '-W0', bench
  }
end
