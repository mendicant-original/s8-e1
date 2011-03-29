require_relative 'spec_helper'

describe Z do
  it '#initialize' do
    Z.new.get_str.should == '0'
    Z.new(2).get_str.should == '2'
  end

  it '+' do
    a, b = Z.new(2), Z.new(3)
    (a+b).get_str.should == '5'
  end
  
  it '*' do
    a, b = Z.new(2), Z.new(3)
    (a*b).get_str.should == '6'

    (a*3).get_str.should == '6'
  end
end
