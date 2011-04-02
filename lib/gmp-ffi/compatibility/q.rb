require_relative '../q'

module GMP
  class Q
    alias :neg :-@
  end
end
