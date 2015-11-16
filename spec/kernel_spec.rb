require 'spec_helper'

describe Kernel do

  describe "#Array(args)" do
    it "returns an array object with args set as the elements in array" do
      array = Array(1..5)
      array_string = Array("cats")
      expect(array).to eq([1,2,3,4,5])
      expect(array_string).to eq(["cats"])
    end
  end

  # describe "#Complex(x[,y])" do
  #   it "" do
  #   end
  # end

  describe "#Float(arg)" do
    it "returns numeric type arg converted as a float directly" do
      floated = Float(2)
      expect(floated).to eq(2.0)
    end

    it "converts arg using arg.to_f and returns a Float type" do
      float = Float("24.42")
      expect(float).to eq(24.42)
    end
  end

end