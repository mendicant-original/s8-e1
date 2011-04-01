require_relative 'z'

# compatibility with the gmp gem (notably useful for testing)

module GMP
  class Z
    alias :nextprime :next_prime
    class << self
      alias :fac :factorial
      alias :fib :fibonacci
    end
  end
end
