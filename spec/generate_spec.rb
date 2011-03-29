require_relative 'spec_helper'

describe 'generate' do
  Examples = {
    :__gmpz_init          => [[:pointer], :void],
    :__gmpz_init_set_si   => [[:pointer, :long], :void],
    :__gmpz_mul_si        => [[:pointer, :pointer, :long], :void],
    :__gmp_printf         => [[:string, :varargs], :int],
    :__gmpz_get_str       => [[:string, :int, :pointer], :string],
  }

  Examples.each_pair { |name, types|
    it "function #{name} types" do
      Lib::Functions[name].should == types
    end
  }
end
