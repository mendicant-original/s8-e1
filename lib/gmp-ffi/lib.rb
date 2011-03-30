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
        function = :"__gmp#{meth}"
        if Functions.key? function
          attach_function meth, function, *Functions[function]
          send(meth, *args, &block)
        else
          super
        end
      end
    end
  end
end
