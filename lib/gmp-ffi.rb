module GMP
  # must be required first or "Symbol not found"
  EXT = begin
    require_relative '../ext/gmp_ffi'
  rescue LoadError
    false
  end

  def GMP.sign i
    i == 0 ? 0 : i > 0 ? 1 : -1
  end

  extend self
  def Z(n = nil)
    Z === n ? n : Z.new(n)
  end

  def Q(n = nil, d = nil)
    Q === n ? n : Q.new(n, d)
  end

  def F(f = nil, round = :RNDN)
    F === f ? f : F.new(f, round)
  end
end

require_relative 'gmp-ffi/struct'
require_relative 'gmp-ffi/lib'
require_relative 'gmp-ffi/mpfr'
require_relative 'gmp-ffi/z'
require_relative 'gmp-ffi/q'
require_relative 'gmp-ffi/f'
require_relative 'gmp-ffi/rand_state'
require_relative 'gmp-ffi/compatibility'
require_relative 'gmp-ffi/takeover'
