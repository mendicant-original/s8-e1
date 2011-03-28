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

    #class MpzStruct < FFI::Struct
    #  struct do |s|
    #    s.name '__mpz_struct'
    #    s.include 'gmp.h'
    #    #s.field :_mp_alloc, :int
    #    #s.field
    #  end
    #end

    attach_function :__gmpz_init, [:pointer], :void
    attach_function :__gmpz_init_set_si, [:pointer, :long], :void

    attach_function :__gmpz_mul, [:pointer, :pointer, :pointer], :void
    attach_function :__gmpz_mul_si, [:pointer, :pointer, :long], :void

    attach_function :__gmp_printf, [:string, :varargs], :int
    attach_function :__gmpz_get_str, [:string, :int, :pointer], :string
  end

  class Z
    include Lib
    attr_reader :ptr
    def initialize(n = nil)
      @ptr = FFI::MemoryPointer.new(:pointer) # should be a pointer to __mpz_struct
      case n
      when Fixnum
        __gmpz_init_set_si(@ptr, n)
      else
        __gmpz_init(@ptr)
      end
    end

    def new
      Z.new.tap { |z| yield(z) }
    end

    def * other
      new { |r|
        case other
        when Fixnum
          __gmpz_mul_si(r.ptr, @ptr, other)
        when Z
          __gmpz_mul(r.ptr, @ptr, other.ptr)
        end
      }
    end

    def show
      __gmp_printf("%Zd\n", :pointer, @ptr)
    end

    def get_str
      __gmpz_get_str(nil, 10, @ptr)
    end
  end
end

include GMP
a = Z.new(2)
p a
a.show

b = Z.new(3)

p c=a*b
c.show
p c.get_str

(c*4).show

max_fixnum = 2**62-1
(c*max_fixnum).show
