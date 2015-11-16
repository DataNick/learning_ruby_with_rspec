require 'spec_helper'

describe Kernel do

  describe "Array(args)" do
    it "returns an array object with args set as the elements in array" do
      array = Array(1..5)
      array_string = Array("cats")
      expect(array).to eq([1,2,3,4,5])
      expect(array_string).to eq(["cats"])
    end
  end

end