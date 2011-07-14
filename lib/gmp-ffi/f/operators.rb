module GMP
  class F
    def + other, round = @round
      case other
      when Float
        new { |r| Mpfr.add_d(r.ptr, @ptr, other, round) }
      when Fixnum
        new { |r| Mpfr.add_si(r.ptr, @ptr, other, round) }
      when F
        new { |r| Mpfr.add(r.ptr, @ptr, other.ptr, round) }
      else
        a, b = other.coerce(self)
        a + b
      end
    end

    def - other, round = @round
      case other
      when Float
        new { |r| Mpfr.sub_d(r.ptr, @ptr, other, round) }
      when Fixnum
        new { |r| Mpfr.sub_si(r.ptr, @ptr, other, round) }
      when F
        new { |r| Mpfr.sub(r.ptr, @ptr, other.ptr, round) }
      else
        a, b = other.coerce(self)
        a - b
      end
    end

    def * other, round = @round
      case other
      when Float
        new { |r| Mpfr.mul_d(r.ptr, @ptr, other, round) }
      when Fixnum
        new { |r| Mpfr.mul_si(r.ptr, @ptr, other, round) }
      when F
        new { |r| Mpfr.mul(r.ptr, @ptr, other.ptr, round) }
      else
        a, b = other.coerce(self)
        a * b
      end
    end

    def / other, round = @round
      case other
      when Float
        new { |r| Mpfr.div_d(r.ptr, @ptr, other, round) }
      when Fixnum
        new { |r| Mpfr.div_si(r.ptr, @ptr, other, round) }
      when F
        new { |r| Mpfr.div(r.ptr, @ptr, other.ptr, round) }
      else
        a, b = other.coerce(self)
        a / b
      end
    end
  end
end
