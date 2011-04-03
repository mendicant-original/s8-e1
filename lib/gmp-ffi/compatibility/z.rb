require_relative '../z'

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
    alias :com :~
    alias :sgn :sign

    alias :old_addmul! :addmul!
    def addmul!(a, b)
      raise RangeError if Fixnum === b and b < 0
      old_addmul!(a, b)
    end

    alias :old_submul! :submul!
    def submul!(a, b)
      raise RangeError if Fixnum === b and b < 0
      old_submul!(a, b)
    end

    class << self
      alias :fac :factorial
      alias :fib :fibonacci
    end
  end
end
