module GMP
  class Q
    def + other
      new { |q| Lib.q_add(q.ptr, @ptr, GMP::Q(other).ptr) }
    end

    def - other
      new { |q| Lib.q_sub(q.ptr, @ptr, GMP::Q(other).ptr) }
    end

    def * other
      new { |q| Lib.q_mul(q.ptr, @ptr, GMP::Q(other).ptr) }
    end

    def / other
      raise ZeroDivisionError if other == 0
      new { |q| Lib.q_div(q.ptr, @ptr, GMP::Q(other).ptr) }
    end
  end
end
