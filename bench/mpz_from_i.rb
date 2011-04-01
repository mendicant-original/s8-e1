require_relative '../lib/gmp-ffi'
require 'benchmark'

N = 2_000

Benchmark.bm(20) do |x|
  [64, 1024, 10240].each { |p|
    n = 2**p-1
    x.report("ruby_from_i 2**#{p}") {
      N.times { GMP::Z.new.send(:ruby_from_i, n) }
    }
    x.report("fast_from_i 2**#{p}") {
      N.times { GMP::Z.new.send(:fast_from_i, n) }
    }
  }
end
