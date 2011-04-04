module GMP
  class Z
    def +@
      self
    end

    def -@
      new { |z| Lib.z_neg(z.ptr, @ptr) }
    end

    def ~
      new { |z| Lib.z_com(z.ptr, @ptr) }
    end

    def & other
      new { |z| Lib.z_and(z.ptr, @ptr, GMP::Z(other).ptr) }
    end

    def | other
      new { |z| Lib.z_ior(z.ptr, @ptr, GMP::Z(other).ptr) }
    end

    def ^ other
      new { |z| Lib.z_xor(z.ptr, @ptr, GMP::Z(other).ptr) }
    end

    def << i
      new { |z| Lib.z_mul_2exp(z.ptr, @ptr, i.to_i) }
    end

    def >> i
      new { |z| Lib.z_fdiv_q_2exp(z.ptr, @ptr, i.to_i) }
    end

    def [](i)
      Lib.z_tstbit(@ptr, i.to_i) == 1
    end

    def []=(i, v)
      if v and v != 0
        Lib.z_setbit(@ptr, i.to_i)
      else
        Lib.z_clrbit(@ptr, i.to_i)
      end
    end

    def scan0 i
      Lib.z_scan0(@ptr, i.to_i)
    end

    def scan1 i
      Lib.z_scan1(@ptr, i.to_i)
    end

    def neg!
      Lib.z_neg(@ptr, @ptr)
      self
    end

    def abs
      new { |z| Lib.z_abs(z.ptr, @ptr) }
    end

    def abs!
      Lib.z_abs(@ptr, @ptr)
      self
    end

    def sign
      GMP.sign @ptr[:_mp_size]
    end
  end
end
