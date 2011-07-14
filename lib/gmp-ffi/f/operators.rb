module GMP
  class F
    def + other, round = @round
      case other
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
      when Fixnum
        new { |r| Mpfr.sub_si(r.ptr, @ptr, other, round) }
      when F
        new { |r| Mpfr.sub(r.ptr, @ptr, other.ptr, round) }
      else
        a, b = other.coerce(self)
        a + b
      end
    end
  end
end
