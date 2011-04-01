require_relative '../lib/gmp-ffi'
require 'benchmark'

N = 2_000

Benchmark.bm(12) do |x|
  [2**64-1, 2**1024+1, 2**10240+1].each { |n|
    p n
    x.report("ruby_from_i") {
      N.times { GMP::Z.ruby_from_i(n) }
    }
    x.report("fast_from_i") {
      N.times { GMP::Z.fast_from_i(n) }
    }
  }
end
