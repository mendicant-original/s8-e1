require_relative '../lib/gmp-ffi' # require 'gmp'
require 'benchmark'

Benchmark.bm(25) do |x|
  n = 20_000
  bd, f = 0.0, GMP::F(0.0)

  [bd, f].each { |b|
    x.report("#{n} additions #{b.class}") {
      n.times { |i| b += i }
    }
  }

  puts

  n = 15_000
  bd, f = 1.0, GMP::F(1.0)
  [bd, f].each { |b|
    x.report("#{n} multiplications #{b.class}") {
      (1..n).inject(b) { |fact, i| fact * i }
    }
  }
end
