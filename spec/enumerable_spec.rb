require 'spec_helper'
# Enumerable mixin provides collection classes with traversal and searching methods, plus ability to sort.

describe Enumerable do

  describe "#all?{|obj|block}" do
    it "passes each element of the collection to the block; returns true if block never returns false or nil" do
      array = %w(entourage mad_men true_detective).all?{|obj| obj.length >= 7}
      expect(array).to eq(true)
    end
  end

  describe "any?{|obj| block}" do
    it "returns true if the block ever returns a value other than false or nil" do
      array = %w[carson leno obrien meyers].any?{|obj| obj.chars.first == "o"}
      expect(array).to eq(true)
    end
  end

  # describe "#chunk{|elt|block}" do
  #   it "" do
  #   end
  # end

  describe "#collect" do
    it "returns a new array with the results of running block once for every element in enum" do
      array = []
      collection = [1,2,4,5,6].collect{|x| if x%2 == 0 then array.push(x) end}
      expect(array).to eq([2, 4, 6])
    end
  end

  describe "#collect_concat {|obj| block} or #flat_map" do
    it "returns new array" do
      concat = [["a"], ["b"], ["c"]].collect_concat{|obj| obj + [100]}
      expect(concat).to eq(["a", 100, "b", 100, "c", 100])
    end
  end

end