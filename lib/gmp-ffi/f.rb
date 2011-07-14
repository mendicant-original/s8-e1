require_relative 'mpfr'

module GMP
  class F
    attr_accessor :ptr
    protected :ptr=
    def initialize(f = nil, round = 0)
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
