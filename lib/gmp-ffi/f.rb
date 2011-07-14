require_relative 'mpfr'

module GMP
  class F
    def self.free! ptr
      # lambda do not work
      Proc.new { Mpfr.clear ptr }
    end

    def def_finalizer
      ObjectSpace.define_finalizer(@ptr, self.class.free!(@ptr.pointer))
    end

    attr_accessor :ptr
    protected :ptr=
    def initialize(f = nil, round = :RNDN)
      @ptr = Struct::F.new # should be a pointer to __mpfr_struct
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
        raise ArgumentError, "Unknown initializer: #{n}"
      end
    end

    private
    def new
      F.new.tap { |f| yield(f) }
    end
  end
end

GMP.require_recursive
