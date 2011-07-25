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

    def prec
      Mpfr.get_prec(@ptr)
    end

    def prec=(precision)
      Mpfr.set_prec(@ptr, precision)
    end
  end
end
