require_relative 'z'

# compatibility with the gmp gem (notably useful for testing)

module GMP
  class Z
    def jacobi(b)
      Z.jacobi(self, b)
    end
    def legendre(p)
      raise RangeError if p.composite?
      Z.jacobi(self, p)
    end

    alias :nextprime :next_prime

    class << self
      alias :fac :factorial
      alias :fib :fibonacci
    end
  end
end
