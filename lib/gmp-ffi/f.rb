require_relative 'mpfr'
require_relative 'f/conversions'
require_relative 'f/identity'
require_relative 'f/bits'
require_relative 'f/operators'

module GMP
  class F
    def self.free(ptr)
      # see doc/ffi_finalizer.txt
      Proc.new { Mpfr.clear ptr }
    end

    def def_finalizer
      ObjectSpace.define_finalizer(@ptr, self.class.free(@ptr.pointer))
    end

    attr_accessor :ptr
    protected :ptr=
    def initialize(f = nil, round = :RNDN)
      @ptr = GMP::Struct::F.new # should be a pointer to __mpfr_struct
      def_finalizer
      @round = round
      Mpfr.init(@ptr)
      case f
      when Fixnum
        Mpfr.set_si(@ptr, f, round)
      when Float
        Mpfr.set_d(@ptr, f, round)
      when NilClass
        Mpfr.set_si(@ptr, 0, round)
      else
        raise ArgumentError, "Unknown initializer: #{f}"
      end
      yield self if block_given?
    end
  end
end
