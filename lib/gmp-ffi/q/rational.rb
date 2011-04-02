module GMP
  class Q
    def inv
      raise ZeroDivisionError if numerator == 0
      new { |q| Lib.q_inv(q.ptr, @ptr) }
    end

    def inv!
      raise ZeroDivisionError if numerator == 0
      Lib.q_inv(@ptr, @ptr)
      self
    end
  end
end
