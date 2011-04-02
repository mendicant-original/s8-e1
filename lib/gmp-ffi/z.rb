require_relative 'lib'

module GMP
  class Z
    attr_reader :ptr
    def initialize(n = nil, copy = true)
      if !copy and Z === n
        @ptr = n.ptr
      else
        @ptr = FFI::MemoryPointer.new(:pointer) # should be a pointer to __mpz_struct
        Lib.z_init(@ptr)
        case n
        when Z
          Lib.z_set(@ptr, n.ptr)
        when Integer
          from_i(n)
        when String
          Lib.z_set_str(@ptr, n, 0)
        end
      end
    end

    def new
      Z.new.tap { |z| yield(z) }
    end
  end
end

GMP.require_recursive
