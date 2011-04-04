require_relative 'lib'

#GC.disable

module GMP
  class Q
    attr_accessor :ptr
    protected :ptr=
    def initialize(n = nil, d = nil)
      @ptr = Struct::MpQ.new # should be a pointer to __mpq_struct
      Lib.q_init(@ptr)
      if d == nil
        case n
        when Q
          Lib.q_set(@ptr, n.ptr)
        when Z
          Lib.q_set_z(@ptr, n.ptr)
        when Bignum
          Lib.q_set_z(@ptr, Z.new(n).ptr) # FIXME
        when Fixnum
          Lib.q_set_si(@ptr, n, 1)
        when String
          raise "Invalid string: #{n.inspect}" unless Lib.q_set_str(@ptr, n, 0) == 0
          Lib.q_canonicalize(@ptr)
        when NilClass
          # default init
        else
          raise ArgumentError, "Unknown initializer: (#{n},#{d})"
        end
      else
        case [n,d].map(&:class)
        when [Fixnum, Fixnum]
          n, d = -n, -d if d < 0
          Lib.q_set_si(@ptr, n, d)
          Lib.q_canonicalize(@ptr)
        when [Z, Z]
          # FIXME
          raise "Invalid string: #{n.inspect}" unless Lib.q_set_str(@ptr, "#{n}/#{d}", 0) == 0
          Lib.q_canonicalize(@ptr)
        else
          raise ArgumentError, "Unknown initializer: (#{n},#{d})"
        end
      end
    end

    def numerator
      GMP::Z(@ptr[:_mp_num])
    end

    def denominator
      GMP::Z(@ptr[:_mp_den])
    end

    private
    def numerator_ptr
      @ptr[:_mp_num]
    end

    def denominator_ptr
      @ptr[:_mp_den]
    end

    def new
      Q.new.tap { |q| yield(q) }
    end
  end
end

GMP.require_recursive
