# some Fixnum and Bignum methods cannot accept arbitrary arguments and do not use coerce
# this make them aware

{ :& => :old_and, :| => :old_or, :^ => :xor }.each_pair { |meth, old|
  [Fixnum, Bignum].each { |klass|
    klass.send(:alias_method, old, meth)
    klass.class_eval <<-EOC, __FILE__, __LINE__
      def #{meth}(other)
        if Numeric === other
          #{old}(other)
        else
          a, b = other.coerce(self)
          a.#{meth}(b)
        end
      end
    EOC
  }
}
