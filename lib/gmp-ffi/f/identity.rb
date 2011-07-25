module GMP
  class F
    include Comparable

    def ==(other)
      case other
      when Float
        Mpfr.cmp_d(@ptr, other) == 0
      when Fixnum
        Mpfr.cmp_si(@ptr, other) == 0
      end
    end

    def <=>(other)
      case other
      when Fixnum
        GMP.sign Mpfr.cmp_si(@ptr, other)
      when Float
        GMP.sign Mpfr.cmp_d(@ptr, other)
      when F
        GMP.sign Mpfr.cmp(@ptr, other.ptr)
      else
        self <=> GMP::F(other)
      end
    end
  end
end
