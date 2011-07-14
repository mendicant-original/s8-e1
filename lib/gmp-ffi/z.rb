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
    def initialize(n = nil)
      if Struct::Z === n
        @ptr = n
      else
        @ptr = Struct::Z.new # should be a pointer to __mpz_struct
        Lib.z_init(@ptr)
        def_finalizer

        case n
        when Z
          Lib.z_set(@ptr, n.ptr)
        when Integer
          from_i(n)
        when String
          Lib.z_set_str(@ptr, n, 0)
        when NilClass
          # default init
        else
          raise ArgumentError, "Unknown initializer: #{n}"
        end
      end
    end

    def set z
      @ptr = z.ptr
      self
    end

    private
    def new
      Z.new.tap { |z| yield(z) }
    end
  end
end

GMP.require_recursive
