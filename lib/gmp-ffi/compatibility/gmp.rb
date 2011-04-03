require_relative '../lib'

module GMP
  Lib::Constants.each_pair { |const, value|
    const_set const, value
  }
end
