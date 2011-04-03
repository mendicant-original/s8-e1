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

    def floor
      Z.new.tap { |z| Lib.z_fdiv_q(z.ptr, numerator_ptr, denominator_ptr) }
    end

    def ceil
      Z.new.tap { |z| Lib.z_cdiv_q(z.ptr, numerator_ptr, denominator_ptr) }
    end

    def truncate
      Z.new.tap { |z| Lib.z_tdiv_q(z.ptr, numerator_ptr, denominator_ptr) }
    end
  end
end
