require_relative 'z'

# compatibility with the gmp gem (notably useful for testing)

module GMP
  class Z
    class << self
      alias :fac :factorial
    end
  end
end
