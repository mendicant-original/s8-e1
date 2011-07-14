module GMP
  class F
    def +@
      self
    end

    def -@
      new { |f| Mpfr.neg(f.ptr, @ptr, @round) }
    end

    def abs
      new { |f| Mpfr.abs(f.ptr, @ptr, @round) }
    end
  end
end
