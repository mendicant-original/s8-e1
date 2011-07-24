require_relative 'lib'
require_relative 'z/conversions'
require_relative 'z/identity'
require_relative 'z/bits'
require_relative 'z/operators'
require_relative 'z/predicates'
require_relative 'z/class'
require_relative 'z/gmp'
require_relative 'z/others'

module GMP
  class Z
    def self.free ptr
      # see doc/ffi_finalizer.txt
      Proc.new { Lib.z_clear ptr }
    end

    def def_finalizer
      ObjectSpace.define_finalizer(@ptr, self.class.free(@ptr.pointer))
    end

    attr_accessor :ptr
    protected :ptr=
    def initialize(n = nil)
      if GMP::Struct::Z === n
        @ptr = n
      else
        @ptr = GMP::Struct::Z.new # should be a pointer to __mpz_struct
        def_finalizer

        case n
        when Z
          Lib.z_init_set(@ptr, n.ptr)
        when Integer
          Lib.z_init(@ptr)
          from_i(n)
        when String
          Lib.z_init_set_str(@ptr, n, 0)
        when NilClass
          Lib.z_init(@ptr) # default init
        else
          raise ArgumentError, "Unknown initializer: #{n}"
        end
      end
      yield self if block_given?
    end

    def set z
      @ptr = z.ptr
      self
    end
  end
end
