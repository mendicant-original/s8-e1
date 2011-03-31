module GMP
  extend self
  def Z(*args)
    Z.new(*args)
  end
end

Dir[File.expand_path('..', __FILE__)+'/gmp-ffi/*'].each { |file| require file }
