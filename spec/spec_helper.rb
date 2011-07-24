require 'rspec'

module ImplementsIt
  def implements meth, &block
    it "implements #{meth}", &block
  end
end
RSpec::Core::ExampleGroup.extend ImplementsIt

require_relative '../lib/gmp-ffi'
require_relative 'shared_examples'
