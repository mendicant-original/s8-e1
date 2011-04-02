require_relative 'spec_helper'

describe 'generate' do
  Examples = {
    :__gmpz_init          => [[:pointer], :void],
    :__gmpz_init_set_si   => [[:pointer, :long], :void],
    :__gmpz_add           => [[:pointer, :pointer, :pointer], :void],
    :__gmpz_mul_si        => [[:pointer, :pointer, :long], :void],
    :__gmp_printf         => [[:string, :varargs], :int],
    :__gmpz_get_str       => [[:string, :int, :pointer], :string],
    :__gmpz_set_str       => [[:pointer, :string, :int], :int],
    :__gmpz_fits_slong_p  => [[:pointer], :int],
    :__gmpz_get_si        => [[:pointer], :long],
    :__gmpz_fib_ui        => [[:pointer, :ulong], :void],
    :__gmpz_tstbit        => [[:pointer, :ulong], :int], # mp_bitcnt_t = ulong
    :__gmpz_scan0         => [[:pointer, :ulong], :ulong],

    :__gmpq_init          => [[:pointer], :void],
    :__gmpq_cmp_si        => [[:pointer, :long, :ulong], :int],
    :__gmpq_get_str       => [[:string, :int, :pointer], :string],
    :__gmpq_set           => [[:pointer, :pointer], :void],
    :__gmpq_set_si        => [[:pointer, :long, :ulong], :void],
    :__gmpq_set_ui        => [[:pointer, :ulong, :ulong], :void],
    :__gmpq_set_str       => [[:pointer, :string, :int], :int],
    :__gmpq_inv           => [[:pointer, :pointer], :void],
  }

  Examples.each_pair { |name, types|
    it name do
      Lib::Functions[name].should == types
    end
  }
end
