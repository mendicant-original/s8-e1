require_relative 'lib'

module GMP
  class Z
    include Comparable

    attr_reader :ptr
    def initialize(n = nil)
      @ptr = FFI::MemoryPointer.new(:pointer) # should be a pointer to __mpz_struct
      Lib.z_init(@ptr)
      case n
      when Z
        Lib.z_set(@ptr, n.ptr)
      when Integer
        from_i(n)
      when String
        Lib.z_set_str(@ptr, n, 0)
      end
    end

    def from_i n
      EXT ? fast_from_i(n) : ruby_from_i(n)
    end

    def new
      Z.new.tap { |z| yield(z) }
    end

    def fits_long?
      Lib.z_fits_slong?(@ptr)
    end

    def == other
      case other
      when Z
        Lib.z_cmp(@ptr, other.ptr) == 0
      when Fixnum
        fits_long? and Lib.z_get_si(@ptr) == other
      when Bignum
        to_i == other
      end
    end

    def <=> other
      case other
      when Z
        sign Lib.z_cmp(@ptr, other.ptr)
      end
    end

    def +@
      self
    end

    def -@
      new { |z| Lib.z_neg(z.ptr, @ptr) }
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

    def - other
      new { |r|
        case other
        when Fixnum
          if other >= 0
            Lib.z_sub_ui(r.ptr, @ptr, other)
          else
            Lib.z_add_ui(r.ptr, @ptr, -other)
          end
        when Z
          Lib.z_sub(r.ptr, @ptr, other.ptr)
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

    def coerce other
      [Z.new(other), self]
    end

    def to_i
      EXT ? fast_to_i : ruby_to_i
    end

    def to_s
      Lib.z_get_str(nil, 10, @ptr)
    end

    def hash
      Lib.z_get_si(@ptr).hash # FIXME
    end

    def eql? other
      Z === other and self == other
    end

    def divisible? by
      case by
      when Z
        Lib.z_divisible?(@ptr, by.ptr)
      when Fixnum
        Lib.z_divisible_ui?(@ptr, by.abs)
      when Bignum
        divisible? Z.new(by)
      end
    end

    def even?
      EXT ? Ext.even?(self) : divisible?(2)
    end

    def odd?
      EXT ? !Ext.even?(self) : !divisible?(2)
    end

    def power?
      Lib.z_perfect_power?(@ptr)
    end

    def square?
      Lib.z_perfect_square?(@ptr)
    end

    def next_prime
      new { |z| Lib.z_nextprime(z.ptr, @ptr) }
    end

    private
    def sign i
      i == 0 ? 0 : i > 0 ? 1 : -1
    end

    def ruby_to_i
      if fits_long?
        Lib.z_get_si(@ptr)
      else
        to_s.to_i
      end
    end

    def ruby_from_i(i)
      case i
      when Fixnum
        Lib.z_set_si(@ptr, i)
      when Bignum
        @ptr = Z.new(i.to_s).ptr
      end
      self
    end

    class << self
      def factorial(n)
        Z.new.tap { |z| Lib.z_fac_ui(z.ptr, n.to_i) }
      end

      def fibonacci(n)
        Z.new.tap { |z| Lib.z_fib_ui(z.ptr, n.to_i) }
      end
    end
  end
end
