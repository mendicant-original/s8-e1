module GMP
  class << Z
    [:addmul, :submul].each { |meth|
      define_method(meth) { |r, a, b|
        r.send(meth, a, b)
      }
    }

    [:add, :divexact, :lcm].each { |meth|
      define_method(meth) { |r, a, b|
        r.set a.send(meth, b)
      }
    }

    def sub(r, a, b)
      r.set GMP::Z(a) - b
    end

    def mul(r, a, b)
      r.set a * b
    end

    [:neg, :abs, :sqrt, :nextprime, :com].each { |meth|
      define_method(meth) { |r, op|
        r.set op.send(meth)
      }
    }

    def divisible? a, b
      a.divisible? b
    end

    def congruent? z, c, d
      z.congruent? c, d
    end

    [:mul_2exp, :cdiv_q_2exp, :cdiv_r_2exp, :fdiv_q_2exp, :fdiv_r_2exp, :tdiv_q_2exp, :tdiv_r_2exp].each { |fun|
      define_method(fun) { |r, a, n|
        raise RangeError if n <= 0
        Lib.send("z_#{fun}", r.ptr, GMP::Z(a).ptr, n)
        r
      }
    }
  end
end
