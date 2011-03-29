require 'ffi'

=begin
in gmp.h:909
#define mpz_init __gmpz_init
__GMP_DECLSPEC void mpz_init __GMP_PROTO ((mpz_ptr));

typedef __mpz_struct *mpz_ptr;
=end

module GMP
  module Lib
    extend FFI::Library
    ffi_lib 'gmp'

    attach_function :__gmpz_init, [:pointer], :void
    attach_function :__gmpz_init_set_si, [:pointer, :long], :void

    attach_function :__gmpz_mul, [:pointer, :pointer, :pointer], :void
    attach_function :__gmpz_mul_si, [:pointer, :pointer, :long], :void

    attach_function :__gmp_printf, [:string, :varargs], :int
    attach_function :__gmpz_get_str, [:string, :int, :pointer], :string
  end
end
