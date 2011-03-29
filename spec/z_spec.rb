require_relative 'spec_helper'

describe Z do
  it '#initialize' do
    Z.new.should == 0
    Z.new(2).should == 2
  end

  it '+' do
    a, b = Z.new(2), Z.new(3)
    (a+b).should == 5

    (a+3).should == 5
  end

  it '*' do
    a, b = Z.new(2), Z.new(3)
    (a*b).should == 6

    (a*3).should == 6
  end
end
