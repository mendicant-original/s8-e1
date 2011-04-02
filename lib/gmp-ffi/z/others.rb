module GMP
  class Z
    def gcd other
      new { |z| Lib.z_gcd(z.ptr, @ptr, GMP::Z(other).ptr) }
    end

    def lcm other
      new { |z| Lib.z_lcm(z.ptr, @ptr, GMP::Z(other).ptr) }
    end
  end
end
