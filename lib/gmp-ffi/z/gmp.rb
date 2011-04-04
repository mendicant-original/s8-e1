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
      z = new { |r| n = Lib.z_remove(r.ptr, @ptr, GMP::Z(factor).ptr) }
      [z, n]
    end

    def divexact other
      new { |z| Lib.z_divexact(z.ptr, @ptr, GMP::Z(other).ptr) }
    end

    def addmul a, b
      new { |z| Lib.z_addmul(z.ptr, GMP::Z(a).ptr, GMP::Z(b).ptr) }
    end

    def addmul! a, b
      Lib.z_addmul(@ptr, GMP::Z(a).ptr, GMP::Z(b).ptr)
      self
    end

    def submul a, b
      new { |z| Lib.z_submul(z.ptr, GMP::Z(a).ptr, GMP::Z(b).ptr) }
    end

    def submul! a, b
      Lib.z_submul(@ptr, GMP::Z(a).ptr, GMP::Z(b).ptr)
      self
    end

    def tdiv other
      raise ZeroDivisionError if other == 0
      Z.new { |z| Lib.z_tdiv_q(z.ptr, @ptr, GMP::Z(other).ptr) }
    end

    def tmod other
      raise ZeroDivisionError if other == 0
      Z.new { |z| Lib.z_tdiv_r(z.ptr, @ptr, GMP::Z(other).ptr) }
    end

    def gcdext other
      [Z.new, Z.new, Z.new].tap { |g, s, t|
        Lib.z_gcdext(g.ptr, s.ptr, t.ptr, @ptr, GMP::Z(other).ptr)
      }
    end

    def cmpabs other
      Lib.z_cmpabs(@ptr, GMP::Z(other).ptr)
    end
  end
end
