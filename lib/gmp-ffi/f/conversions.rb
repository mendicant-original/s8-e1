module GMP
  class F
    def to_f(round = @round)
      Mpfr.get_d(@ptr, round)
    end

    def to_s(base = 10, round = @round)
      to_f.to_s
    end
  end
end
