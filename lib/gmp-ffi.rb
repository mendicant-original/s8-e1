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

  def require_recursive
    file = caller.first.partition(':').first
    Dir[File.expand_path("../#{File.basename(file,'.rb')}/*.rb", file)].each { |f| require f }
  end
end

GMP.require_recursive
