require_relative 'spec_helper'

describe F do
  it 'initialize' do
    F.new.should == 0
    F.new(0).should == 0
    F.new(0.0).should == 0.0
  end
end
