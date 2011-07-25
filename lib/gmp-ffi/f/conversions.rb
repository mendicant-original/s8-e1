module GMP
  class F
    def coerce(other)
      [GMP::F(other), self]
    end

    def to_f(round = @round)
      Mpfr.get_d(@ptr, round)
    end

    def to_s(digits = nil, base = 10, round = @round)
      digits ||= Math.log10(2**prec).floor
      int_ptr = FFI::MemoryPointer.new(:int)
      str = Mpfr.get_str(nil, int_ptr, base, digits, @ptr, round)
      exp = int_ptr.read_int
      if str[-1] == '@'
        case str
        when  '@NaN@' then 'NaN'
        when  '@Inf@' then 'Infinity'
        when '-@Inf@' then '-Infinity'
        end
      else
        if exp > 0
          str.insert exp, '.'
        else
          str.prepend "0.#{'0' * exp.abs}"
        end
        str.sub!(/\.?0+\z/,'') # safe because we always add the .
        str
      end
    end
  end
end
