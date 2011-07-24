module GMP
  class Z
    def + other
      case other
      when Fixnum
        Z.new { |r|
          if other >= 0
            Lib.z_add_ui(r.ptr, @ptr, other)
          else
            Lib.z_sub_ui(r.ptr, @ptr, -other)
          end
        }
      when Bignum
        self + Z.new(other)
      when Z
        Z.new { |r| Lib.z_add(r.ptr, @ptr, other.ptr) }
      else
        a, b = other.coerce(self)
        a + b
      end
    end

    def - other
      case other
      when Fixnum
        Z.new { |r|
          if other >= 0
            Lib.z_sub_ui(r.ptr, @ptr, other)
          else
            Lib.z_add_ui(r.ptr, @ptr, -other)
          end
        }
      when Bignum
        self - Z.new(other)
      when Z
        Z.new { |r| Lib.z_sub(r.ptr, @ptr, other.ptr) }
      else
        a, b = other.coerce(self)
        a - b
      end
    end

    def * other
      case other
      when Fixnum
        Z.new { |r| Lib.z_mul_si(r.ptr, @ptr, other) }
      when Bignum
        self * Z.new(other)
      when Z
        Z.new { |r| Lib.z_mul(r.ptr, @ptr, other.ptr) }
      else
        a, b = other.coerce(self)
        a * b
      end
    end

    PowerModulo = Z.new(1<<128)
    def ** exp
      Z.new { |r|
        case exp
        when Fixnum
          if exp >= 0
            Lib.z_pow_ui(r.ptr, @ptr, exp)
          end
        when Bignum
          self ** Z.new(other)
        when Z
          Lib.z_powm(r.ptr, @ptr, exp.ptr, PowerModulo.ptr) # FIXME
        end
      }
    end

    def sqrt
      Z.new { |z| Lib.z_sqrt(z.ptr, @ptr) }
    end
  end
end
