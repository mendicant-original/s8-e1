require_relative 'spec_helper'

describe F do
  two = F(2)
  three = F(3)

  it 'initialize' do
    F.new.should == 0
    F.new(0).should == 0
    F.new(0.0).should == 0.0
    two.should == 2
  end

  it '==' do
    F.new.should == 0
    0.should == F.new
    2.should == two
  end

  it '+' do
    (two + three).should == 5.0
    (F(0.2)+F(0.3)).should == 0.5
    (F(-0.2)+F(-0.3)).should == -0.5
  end

  it '-' do
    (two - three).should == -1
    (F(0.2)-F(0.3)).to_f.should be_within(1e-16).of(-0.1)
  end

  it 'to_s' do
    F(0.25).to_s.should == '0.25'
    F(0.0025).to_s.should == '0.0025'
    F(25.024).to_s.should == '25.024'
  end
end
