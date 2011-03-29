require_relative 'lib'

module GMP
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
