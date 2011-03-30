require_relative 'lib'

module GMP
  class Z
    attr_reader :ptr
    def initialize(n = nil)
      @ptr = FFI::MemoryPointer.new(:pointer) # should be a pointer to __mpz_struct
      case n
      when Fixnum
        Lib.z_init_set_si(@ptr, n)
      else
        Lib.z_init(@ptr)
      end
    end

    def new
      Z.new.tap { |z| yield(z) }
    end

    def fits_long?
      Lib.z_fits_slong_p(@ptr) == 1
    end

    def == other
      case other
      when Fixnum
        fits_long? and Lib.z_get_si(@ptr) == other
      end
    end

    def + other
      new { |r|
        case other
        when Fixnum
          if other >= 0
            Lib.z_add_ui(r.ptr, @ptr, other)
          else
            Lib.z_sub_ui(r.ptr, @ptr, -other)
          end
        when Z
          Lib.z_add(r.ptr, @ptr, other.ptr)
        end
      }
    end

    def * other
      new { |r|
        case other
        when Fixnum
          Lib.z_mul_si(r.ptr, @ptr, other)
        when Z
          Lib.z_mul(r.ptr, @ptr, other.ptr)
        end
      }
    end

    def to_s
      Lib.z_get_str(nil, 10, @ptr)
    end
  end
end