require_relative 'spec_helper'

describe 'C extension' do
  it_should_behave_like 'Z#to_i', :fast_to_i
end
