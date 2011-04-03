module GMP
  class Q
     include Comparable

    def dup
      Q.new(self)
    end

    def == other
      case other
      when Q
        Lib.q_cmp(@ptr, other.ptr) == 0
      when Z
        Lib.q_cmp(@ptr, GMP::Q(other).ptr) == 0
      when Fixnum
        Lib.q_cmp_si(@ptr, other, 1) == 0
      when Rational
        Lib.q_cmp_si(@ptr, other.numerator, other.denominator) == 0
      end
    end

    def <=> other
      case other
      when Q
        cmp = Lib.q_cmp(@ptr, other.ptr)
        cmp == 0 ? 0 : cmp > 0 ? 1 : -1
      else # FIXME
        self <=> GMP::Q(other)
      end
    end

    def hash
      numerator.hash ^ denominator.hash
    end

    def eql? other
      Q === other and self == other
    end
  end
end
