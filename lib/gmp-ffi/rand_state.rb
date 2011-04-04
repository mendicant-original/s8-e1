module GMP
  class RandState
    def initialize
      @ptr = Struct::RandState.new
      Lib.randinit_default(@ptr)
    end

    def seed seed
      case seed
      when Fixnum
        Lib.randseed_ui(@ptr, seed)
      end
    end

    def urandomb n
      case n
      when Fixnum
        Z.new Lib.urandomb_ui(@ptr, n)
      else
        Z.new.tap { |z| Lib.z_urandomb(z.ptr, @ptr, GMP::Z(n).ptr) }
      end
    end

    def urandomm n
      case n
      when Fixnum
        Z.new Lib.urandomm_ui(@ptr, n)
      else
        Z.new.tap { |z| Lib.z_urandomm(z.ptr, @ptr, GMP::Z(n).ptr) }
      end
    end

    def rrandomb n
      Z.new.tap { |z| Lib.z_rrandomb(z.ptr, @ptr, n.to_i) }
    end
  end
end
