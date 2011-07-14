require_relative '../lib/gmp-ffi' # require 'gmp'
require 'benchmark'

Benchmark.bm(25) do |x|
  n = 10_000
  big, z = 2**100, GMP::Z(2**100)

  [big, z].each { |b|
    x.report("#{n} additions #{b.class}") {
      n.times { |i| b += i }
    }
  }

  puts

  n = 15_000
  big, z = 1, GMP::Z(1)
  [big, z].each { |b|
    x.report("#{n}! #{b.class}") {
      (1..n).inject(b) { |fact, i| fact * i }
    }
  }
end
