require_relative 'spec_helper'

describe 'C extension' do
  it_should_behave_like 'Z#to_i', :fast_to_i

  it_should_behave_like 'Z#from_i', :fast_from_i
end
