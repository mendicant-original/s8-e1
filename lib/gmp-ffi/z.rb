require_relative 'lib'

module GMP
  class Z
    def self.free! ptr
      # lambda do not work
      Proc.new { Lib.z_clear ptr }
    end

    def def_finalizer
      ObjectSpace.define_finalizer(@ptr, self.class.free!(@ptr.pointer))
    end

    attr_accessor :ptr
    protected :ptr=
    def initialize(n = nil, copy = true)
      if !copy and Z === n
        @ptr = n.ptr
      elsif Struct::MpZ === n
        @ptr = n
      else
        @ptr = Struct::MpZ.new # should be a pointer to __mpz_struct
        Lib.z_init(@ptr)
        def_finalizer

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

    private
    def new
      Z.new.tap { |z| yield(z) }
    end
  end
end

GMP.require_recursive
