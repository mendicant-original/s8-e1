require_relative '../q'

module GMP
  class Q
    alias :neg :-@
    alias :trunc :truncate
  end
end
