SharedExamplesNumbers = [-18446462598732906496, -2**62-1, -2**62, -2**30-1, -2**30, -7, 42, 2**30-1, 2**30, 2**62-1, 2**62, 18446462598732906496]

shared_examples_for 'Z#to_i' do |meth|
  it "Z##{meth}" do
    SharedExamplesNumbers.each { |n|
      i = Z.new(n).send(meth)
      n.should == i
      i.class.should be n.class
    }
  end
end

shared_examples_for 'Z#from_i' do |meth|
  it "Z##{meth}" do
    SharedExamplesNumbers.each { |n|
      z = Z.new
      z.send(meth, n)
      z.should == n
    }
  end
end
