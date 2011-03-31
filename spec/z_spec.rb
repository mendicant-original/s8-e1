require_relative 'spec_helper'

describe Z do
  let(:two) { Z.new 2 }
  let(:three) { Z.new 3 }

  it '#initialize' do
    Z.new.should == 0
    two.should == 2
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
  end

  it '*' do
    (two*three).should == 6

    (two*3).should == 6
  end
end
