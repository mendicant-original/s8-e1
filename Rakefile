task :default => :check

task :check => [:spec, :test]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec => :build)

task :test => :build do
  dir = Object.new
  def dir./(glob)
    "tests_from_gmp_gem/#{glob}.rb"
  end
  tests = Dir[dir/'*'].reject { |test|
    File.read(test) =~ /\bGMP::F\b|MPFR/
  }
  tests.delete dir/'gmp_tgcd' # seems buggy data

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

file 'ffi/functions.yml' => 'ffi/generate.rb' do
  ruby 'ffi/generate.rb'
end

task :clean do
  Dir['ffi/{gmp.preprocessed.h,{constants,functions}.yml}'].each { |file| rm file }
  Dir['ext/{gmp_ffi.{bundle,so,dll},Makefile}'].each { |file| rm file }
end

task :bench => :build do
  Dir['bench/*.rb'].each { |bench|
    ruby '-W0', bench
  }
end
