require_relative 'spec_helper'

describe Q do
  it 'initialize' do
    Q.new.should == 0
    Q.new(1,2).should == Rational(1,2)
    Q.new('1/3').should == Rational(1,3)
  end
end
