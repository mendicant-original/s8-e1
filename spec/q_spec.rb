require_relative 'spec_helper'

describe GMP::Q do
  it 'initialize' do
    GMP::Q.new.should == 0
    GMP::Q(1,2).should == Rational(1,2)
    GMP::Q('1/3').should == Rational(1,3)
  end
end
