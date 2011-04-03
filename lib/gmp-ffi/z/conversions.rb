module GMP
  class Z
    def coerce other
      [GMP::Z(other), self]
    end

    def from_i n
      EXT ? fast_from_i(n) : ruby_from_i(n)
    end

    def to_i
      EXT ? fast_to_i : ruby_to_i
    end

    def to_s(base = 10)
      Lib.z_get_str(nil, base, @ptr)
    end

    def to_f
      Lib.z_get_d(@ptr)
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
        Lib.z_set_str(@ptr, i.to_s, 0)
      end
      self
    end
  end
end
