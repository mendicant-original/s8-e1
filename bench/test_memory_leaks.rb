require_relative '../lib/gmp-ffi'

#GC.disable

def memory
  [Bignum, GMP::Z, GMP::Struct::Z, GMP::Q, GMP::Struct::Q, GMP::F, GMP::Struct::F, FFI::Pointer, FFI::MemoryPointer].each { |c|
    puts "#{c}: #{ObjectSpace.each_object(c) {}}"
  }
  puts
end

memory

z = nil
n = 1<<6400
pi = Math::PI
r = "#{n}/#{n+1}"
N = 100_000
N.times { |i|
  z = GMP::Z.new(n)
  q = GMP::Q.new(*r)
  f = GMP::F.new(pi)
  if i % (N/25) == 0
    #GC.start
    p i
    memory
  end

}
z = nil
n = nil

memory

GC.start

memory
