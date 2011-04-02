require_relative 'spec_helper'

describe Z do
  two = Z.new 2
  three = Z.new 3

  it 'new, GMP::Z()' do
    GMP::Z(two).ptr.should == two.ptr
    Z.new(two).ptr.should_not == two.ptr
  end

  it 'initialize' do
    Z.new.should == 0
    two.should == 2
  end

  it 'dup' do
    z = two.dup
    z.ptr.should_not == two.ptr
    z[0] = 1
    z.should == 3
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

  it '<=>' do
    two.should be < three
    two.should be <= three
    three.should be >= two
    three.should be > two
    two.should be >= two
    two.should be <= two
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

  it 'factorial' do
    Z.factorial(0).should == 1
    Z.factorial(1).should == 1
    Z.factorial(2).should == 2
    Z.factorial(3).should == 6
    Z.factorial(6).should == 720
    Z.factorial(30).should == 265252859812191058636308480000000
  end

  it 'to_s' do
    two.to_s.should == '2'
    Z(12345678909876543210).to_s.should == '12345678909876543210'
  end

  it 'lcm' do
    three.lcm(two).should == 6
    two.lcm(two).should == two
    three.lcm(three).should == three
    Z(124).lcm(135).should == 16740
    Z(2**35*3**29).lcm(2**37*3**28).should == 2**37*3**29
  end

  it_should_behave_like 'Z#to_i', :ruby_to_i
  it_should_behave_like 'Z#from_i', :ruby_from_i
end
