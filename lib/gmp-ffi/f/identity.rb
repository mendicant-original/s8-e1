module GMP
  class F
    def == other
      case other
      when Float
        Mpfr.cmp_d(@ptr, other) == 0
      when Fixnum
        Mpfr.cmp_si(@ptr, other) == 0
      end
    end
  end
end
