module GMP
  class Z
    class << self
      def pow(a, b)
        raise unless a > 0 and b > 0
        Z.new.tap { |z| Lib.z_ui_pow_ui(z.ptr, a, b) }
      end

      def factorial(n)
        Z.new.tap { |z| Lib.z_fac_ui(z.ptr, n.to_i) }
      end

      def fibonacci(n)
        Z.new.tap { |z| Lib.z_fib_ui(z.ptr, n.to_i) }
      end

      def jacobi(a, b)
        raise RangeError unless b.odd? and b > 0
        Lib.z_jacobi(GMP::Z(a).ptr, GMP::Z(b).ptr)
      end
    end
  end
end
