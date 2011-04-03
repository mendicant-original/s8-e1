module GMP
  class Q
    def +@
      self
    end

    def -@
      new { |q| Lib.q_neg(q.ptr, @ptr) }
    end

    def neg!
      Lib.q_neg(@ptr, @ptr)
      self
    end

    def abs
      new { |q| Lib.q_abs(q.ptr, @ptr) }
    end

    def abs!
      Lib.q_abs(@ptr, @ptr)
      self
    end

    def sign
      numerator.sign
    end
  end
end
