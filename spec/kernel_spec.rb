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

  describe "#Hash(arg)" do
    it "converts args to hash object using #to_hash" do
      hash = Hash([])
      expect(hash).to eq({})
    end

    it "converts args to keys and values in hash object" do
      values = Hash(pry: :car)
      expect(values).to eq({:pry => :car})
    end
  end

  # describe "#Integer(arg, base = 0)" do
  #   it "" do
  #   end
  # end

  # describe "#Rational(x[,y])" do
  #   it "" do
  #   end
  # end

  describe "#String" do
    it "returns string object by calling #to_str on arg" do
      string = String(:car)
      expect(string).to eq("car")
    end
  end

  # __callee__ → symbol
  # __dir__ → string
  # __method__ → symbol
  # `cmd` → string

  describe "#require" do
    it "returns a boolean determining the success of loading a file" do
      file = require 'array_spec'
      expect(file).to eq(true)
    end
  end

end