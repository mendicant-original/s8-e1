require_relative 'lib'

#GC.disable

module GMP
  class Q
    attr_reader :ptr
    def initialize(n = nil, d = nil, copy = true)
      if !copy and Q === n and d == nil
        @ptr = n.ptr
      else
        @ptr = Struct::MpQ.new # should be a pointer to __mpq_struct
        Lib.q_init(@ptr)
        if d == nil
          case n
          when Q
            Lib.q_set(@ptr, n.ptr)
          when String
            raise "Invalid string: #{n.inspect}" unless Lib.q_set_str(@ptr, n, 0) == 0
            Lib.q_canonicalize(@ptr)
          end
        else
          case [n,d].map(&:class)
          when [Fixnum, Fixnum]
            Lib.q_set_si(@ptr, n, d)
            Lib.q_canonicalize(@ptr)
          end
        end
      end
    end

    def numerator
      GMP::Z(@ptr[:_mp_num])
    end

    def denominator
      GMP::Z(@ptr[:_mp_den])
    end

    def new
      Q.new.tap { |q| yield(q) }
    end
  end
end

GMP.require_recursive
