module GMP
  class Z
    include Comparable

    def dup
      Z.new(self)
    end

    def == other
      case other
      when Z
        Lib.z_cmp(@ptr, other.ptr) == 0
      when Fixnum
        fits_long? and Lib.z_get_si(@ptr) == other
      when Bignum
        to_i == other
      end
    end

    def <=> other
      case other
      when Z
        sign Lib.z_cmp(@ptr, other.ptr)
      else # FIXME
        self <=> GMP::Z(other)
      end
    end

    def hash
      Lib.z_get_si(@ptr).hash # FIXME
    end

    def eql? other
      Z === other and self == other
    end
  end
end