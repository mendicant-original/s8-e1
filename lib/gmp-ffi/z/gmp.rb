module GMP
  class Z
    def fits_long?
      Lib.z_fits_slong?(@ptr)
    end

    def powmod(exp, mod)
      new { |r|
        case exp
        when Fixnum
          Lib.z_powm_ui(r.ptr, @ptr, exp, GMP::Z(mod).ptr)
        when Z
          Lib.z_powm(r.ptr, @ptr, exp.ptr, GMP::Z(mod).ptr)
        end
      }
    end

    def next_prime
      new { |z| Lib.z_nextprime(z.ptr, @ptr) }
    end

    def invert mod
      new { |z|
        Lib.z_invert(z.ptr, @ptr, mod.ptr)
      }
    end

    def remove factor
      n = nil
      z = new { |z| n = Lib.z_remove(z.ptr, @ptr, GMP::Z(factor).ptr) }
      [z, n]
    end

    def addmul! a, b
      Lib.z_addmul(@ptr, GMP::Z(a).ptr, GMP::Z(b).ptr)
      self
    end

    def submul! a, b
      Lib.z_submul(@ptr, GMP::Z(a).ptr, GMP::Z(b).ptr)
      self
    end
  end
end
