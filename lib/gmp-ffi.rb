module GMP
  # must be required first or "Symbol not found"
  EXT = begin
    require_relative '../ext/gmp_ffi'
  rescue LoadError
    false
  end

  def GMP.sign i
    i == 0 ? 0 : i > 0 ? 1 : -1
  end

  extend self
  def Z(n = nil)
    Z.new(n, false)
  end

  def Q(n = nil, d = nil)
    Q.new(n, d, false)
  end

  def require_recursive
    file = caller.first.partition(':').first
    Dir[File.expand_path("../#{File.basename(file,'.rb')}/*.rb", file)].each { |f| require f }
  end
end

GMP.require_recursive
