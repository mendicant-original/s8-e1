module GMP
  class Q
    def +@
      self
    end

    def -@
      Q.new { |q| Lib.q_neg(q.ptr, @ptr) }
    end

    def neg!
      Lib.q_neg(@ptr, @ptr)
      self
    end

    def abs
      Q.new { |q| Lib.q_abs(q.ptr, @ptr) }
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
