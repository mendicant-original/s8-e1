module GMP
  class Q
    def coerce other
      [GMP::Q(other), self]
    end

    def to_s
      Lib.q_get_str(nil, 10, @ptr)
    end
  end
end
