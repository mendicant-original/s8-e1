module GMP
  class Z
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

    PowerModulo = Z.new(1<<128)
    def ** exp
      new { |r|
        case exp
        when Fixnum
          if exp >= 0
            Lib.z_pow_ui(r.ptr, @ptr, exp)
          end
        when Z
          Lib.z_powm(r.ptr, @ptr, exp.ptr, PowerModulo.ptr) # FIXME
        end
      }
    end
  end
end
