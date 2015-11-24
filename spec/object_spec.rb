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

  describe "#send(:sym[args]) --> obj" do
    it "invokes a method signified by :sym and passes in specified arguments" do
      a = [3,2,4,1,5]
      a.send(:sort!)
      expect(a).to eq([1,2,3,4,5])
    end
  end


end