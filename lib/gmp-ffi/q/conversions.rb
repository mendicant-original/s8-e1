module GMP
  class Q
    def coerce other
      [GMP::Q(other), self]
    end

    def to_s
      Lib.q_get_str(nil, 10, @ptr)
    end

    def to_f
      Lib.q_get_d(@ptr)
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
