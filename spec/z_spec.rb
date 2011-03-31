require_relative 'spec_helper'

describe Z do
  two = Z.new 2
  three = Z.new 3

  it 'initialize' do
    Z.new.should == 0
    two.should == 2
  end

  it '==' do
    two.should == 2
    2.should == two
    two.should == two

    two.should_not == 3
    3.should_not == 2
    two.should_not == three
  end

  it '+@' do
    (+two).should == two
    (+two).should == 2
  end

  it '-@' do
    (-two).should == -2
    (-two).should == two*-1
    (-(-two)).should == 2
    (-(-two)).should == two
  end

  it '+' do
    (two+three).should == 5
    (two-three).should == -1

    (two+3).should == 5
    (two-3).should == -1

    (3-two).should == 1
    (2-three).should == -1
  end

  it '*' do
    (two*three).should == 6

    (two*3).should == 6

    (2*three).should == 6
  end

  it '!' do
    Z(0).!.should == 1
    Z(1).!.should == 1
    two.!.should == 2
    three.!.should == 6
    Z(6).!.should == 720
    Z(30).!.should == 265252859812191058636308480000000
  end

  it 'to_s' do
    two.to_s.should == '2'
    Z(12345678909876543210).to_s.should == '12345678909876543210'
  end
end
