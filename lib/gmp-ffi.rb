module GMP
  # must be required first or "Symbol not found"
  EXT = begin
    require_relative '../ext/gmp_ffi'
  rescue LoadError
    false
  end

  extend self
  def Z(n = nil)
    Z.new(n, false)
  end
end

Dir[File.dirname(__FILE__)+'/gmp-ffi/*.rb'].each { |file| require file }
