require_relative 'spec_helper'

describe GMP::F do
  two = GMP::F(2)
  three = GMP::F(3)

  implements 'initialize' do
    GMP::F.new.should == 0
    GMP::F.new(0).should == 0
    GMP::F.new(0.0).should == 0.0
    two.should == 2
  end

  implements '==' do
    GMP::F.new.should == 0
    0.should == GMP::F.new
    2.should == two
  end

  implements '<=>' do
    two.should be < three
    three.should be > two
    two.should be <= two
    GMP::F(-0.1).should be < GMP::F(0.1)
    GMP::F(0.1).should be > GMP::F(0.01)
  end

  implements '+' do
    (two + three).should == 5.0
    (GMP::F(0.2)+GMP::F(0.3)).should == 0.5
    (GMP::F(-0.2)+GMP::F(-0.3)).should == -0.5
  end

  implements '-' do
    (two - three).should == -1
    (GMP::F(0.2)-GMP::F(0.3)).should be_within(1e-16).of(-0.1)
    (two-0.5).should == 1.5
  end

  implements '*' do
    (two * three).should == 6
    (two * -2).should == -4
    (GMP::F(0.2) * GMP::F(0.3)).should == 0.06
  end

  implements '/' do
    (two / three).should == 0.6666666666666666
    (two / GMP::F(0)).should == Float::INFINITY
    (-two / GMP::F(0)).should == -Float::INFINITY
    (GMP::F(0) / 0).should == Float::NAN
  end

  implements 'to_f' do
    GMP::F(0.0025).to_f.should == 0.0025
  end

  implements 'to_s' do
    GMP::F(0.25).to_s.should == '0.25'
    GMP::F(0.0025).to_s.should == '0.0025'
    GMP::F(25.024).to_s.should == '25.024'
  end

  implements 'abs' do
    two.abs.should == 2
    (-two).abs.should == 2
  end
end
