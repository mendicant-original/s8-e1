 # must be required first or "Symbol not found"
require_relative '../ext/gmp_ffi' rescue nil

module GMP
  extend self
  def Z(*args)
    Z.new(*args)
  end
end

Dir[File.expand_path('..', __FILE__)+'/gmp-ffi/*'].each { |file| require file }
