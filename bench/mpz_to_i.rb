# WOW, this fails if first: require_relative '../lib/gmp-ffi'
require_relative '../ext/gmp_ffi'
require_relative '../lib/gmp-ffi'

require 'benchmark'

N = 100_000

Benchmark.bm(12) do |x|
  [2**64-1, 2**1024+1].each { |n|
    p n
    n = GMP::Z.new(n)
    x.report("to_i") {
      N.times { n.to_i }
    }
    x.report("fast_to_i") {
      N.times { n.fast_to_i }
    }
  }
end
