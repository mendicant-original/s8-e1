require 'ffi'
require 'psych'
require 'yaml'

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

    FunctionsFile = File.expand_path('../../../ffi/functions.yml', __FILE__)
    Functions = YAML.load_file FunctionsFile

    class << self
      def method_missing(meth, *args, &block)
        if meth[-1] == '?' # predicate
          fun = meth[0...-1] << '_p'
          define_singleton_method(meth) do |*args|
            send(fun, *args) == 1
          end
        elsif Functions.key?(function = :"__gmp#{meth}")
          attach_function meth, function, *Functions[function]
        else
          super
        end
        send(meth, *args, &block)
      end
    end
  end
end
