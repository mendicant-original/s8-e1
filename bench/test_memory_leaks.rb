require_relative '../lib/gmp-ffi'

#GC.disable

def memory
  [Bignum, GMP::Z, GMP::Struct::Z, GMP::Q, GMP::Struct::Q, GMP::F, GMP::Struct::F, FFI::Pointer, FFI::MemoryPointer].each { |c|
    puts "#{c}: #{ObjectSpace.each_object(c) {}}"
  }
  memory_used
  puts
end

def memory_used
  mem = `ps aux | grep #{$0}`.lines.inject(0) { |mem, line|
    mem + (line.split(/\s+/)[3].to_f / 100 * MEM)
  }
  puts "#{mem.round} MB"
  mem
end

MEM = system('free &> /dev/null') ? `free -m`.lines.take(2).last.scan(/\d+/).first.to_i : 1792 # MB

memory

z, q, f = nil, nil, nil
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
q = nil
f = nil
n = nil
r = nil

memory

GC.start

memory
