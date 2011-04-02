module GMP
  class Q
    def dup
      Q.new(self)
    end

    def == other
      case other
      when Q
        Lib.q_cmp(@ptr, other.ptr) == 0
      when Fixnum
        Lib.q_cmp_si(@ptr, other, 1) == 0
      when Rational
        Lib.q_cmp_si(@ptr, other.numerator, other.denominator) == 0
      end
    end
  end
end
