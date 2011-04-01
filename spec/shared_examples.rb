shared_examples_for 'Z#to_i' do |meth|
  it "Z##{meth}" do
    [-2**62-1, -2**62, -2**30-1, -2**30, -7, 42, 2**30-1, 2**30, 2**62-1, 2**62].each { |n|
      i = Z.new(n).send(meth)
      n.should == i
      i.class.should be n.class
    }
  end
end
