module GMP
  class F
    def +@
      self
    end

    def -@
      F.new { |f| Mpfr.neg(f.ptr, @ptr, @round) }
    end

    def abs
      F.new { |f| Mpfr.abs(f.ptr, @ptr, @round) }
    end
  end
end
