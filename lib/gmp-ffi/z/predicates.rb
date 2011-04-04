module GMP
  class Z
    def divisible? by
      case by
      when Z
        Lib.z_divisible?(@ptr, by.ptr)
      when Fixnum
        Lib.z_divisible_ui?(@ptr, by.abs)
      when Bignum
        divisible? Z.new(by)
      end
    end

    def even?
      EXT ? fast_even?(self) : divisible?(2)
    end

    def odd?
      EXT ? !fast_even?(self) : !divisible?(2)
    end

    def power?
      Lib.z_perfect_power?(@ptr)
    end

    def square?
      Lib.z_perfect_square?(@ptr)
    end

    def prime? # FIXME
      require 'prime'
      to_i.prime?
    end

    def composite?
      Lib.z_probab_prime_p(@ptr, 5) == 0
    end

    def congruent? c, d
      if Fixnum === c and Fixnum == d
        Lib.z_congruent_ui_p(@ptr, c, d) != 0
      else
        Lib.z_congruent_p(@ptr, GMP::Z(c).ptr, GMP::Z(d).ptr) != 0
      end
    end
  end
end
