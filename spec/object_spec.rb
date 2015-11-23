require 'spec_helper'

describe Object do

  describe "#nil?" do
    it "returns true if object == nil" do
      result = nil.nil?
      expect(result).to eq(true)
    end
  end

  describe "#method(sym)" do
    it "looks up a named method as a receiver to obj and returns a method object" do
      a = [3,5,1,4,2].method(:sort) #will return <Method: Array#sort!>
      b = a.call
      expect(b).to eq([1,2,3,4,5])
    end
  end


end