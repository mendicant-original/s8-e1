require_relative '../lib/gmp-ffi'
require 'benchmark'

N = 50_000

Benchmark.bm(15) do |x|
  [64, 1024].each { |p|
    n = GMP::Z.new(2**p-1)
    x.report("ruby_to_i #{p}") {
      N.times { n.send(:ruby_to_i) }
    }
    x.report("fast_to_i #{p}") {
      N.times { n.send(:fast_to_i) }
    }
  }
end
