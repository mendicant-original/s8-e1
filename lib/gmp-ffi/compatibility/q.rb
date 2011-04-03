require_relative '../q'

module GMP
  class Q
    alias :neg :-@
    alias :sgn :sign
    alias :trunc :truncate
    alias :to_d :to_f
  end
end
