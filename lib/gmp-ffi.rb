module GMP
  class << self
    def Z(*args)
      Z.new(*args)
    end
  end
end

Dir[File.expand_path('..', __FILE__)+'/gmp-ffi/*'].each { |file| require file }
