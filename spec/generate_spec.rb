require_relative 'spec_helper'

describe 'generate' do
  Examples = {
    :__gmpz_init          => [[:pointer], :void],
    :__gmpz_init_set_si   => [[:pointer, :long], :void],
    :__gmpz_add           => [[:pointer, :pointer, :pointer], :void],
    :__gmpz_mul_si        => [[:pointer, :pointer, :long], :void],
    :__gmp_printf         => [[:string, :varargs], :int],
    :__gmpz_get_str       => [[:string, :int, :pointer], :string],
    :__gmpz_fits_slong_p  => [[:pointer], :int],
    :__gmpz_get_si        => [[:pointer], :long],
  }

  Examples.each_pair { |name, types|
    it name do
      Lib::Functions[name].should == types
    end
  }
end
