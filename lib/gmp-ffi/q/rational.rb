module GMP
  class Q
    def inv
      raise ZeroDivisionError if numerator == 0
      # throw floating point exception
      # new { |q| Lib.q_inv(q.ptr, @ptr) }
      Q.new(denominator, numerator)
    end

    def inv!
      # throw floating point exception
      # Lib.q_inv(@ptr, @ptr)
      @ptr = inv.ptr
      self
    end
  end
end
