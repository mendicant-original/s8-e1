require_relative '../lib/gmp-ffi' # require 'gmp'
require 'benchmark'

Benchmark.bm(30) do |x|
  n = 10_000
  r, q = Rational(1), GMP::Q(1)

  x.report("#{n} additions #{r.class}") {
    n.times { |i| r += Rational(1, i+1) }
  }
  x.report("#{n} additions #{q.class}") {
    n.times { |i| q += GMP::Q(1, i+1) }
  }

  puts

  n = 15_000
  r, q = Rational(1), GMP::Q(1)
  x.report("#{n} multiplications #{r.class}") {
    n.times { |i| r *= Rational(i, i+1) }
  }
  x.report("#{n} multiplications #{q.class}") {
    n.times { |i| q *= GMP::Q(i, i+1) }
  }
end
