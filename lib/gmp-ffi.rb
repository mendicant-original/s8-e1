module GMP
  # must be required first or "Symbol not found"
  EXT = begin
    require_relative '../ext/gmp_ffi'
  rescue LoadError
    false
  end

  extend self
  def Z(*args)
    Z.new(*args)
  end
end

Dir[File.expand_path('..', __FILE__)+'/gmp-ffi/*'].each { |file| require file }
