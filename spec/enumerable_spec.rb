require 'spec_helper'
# Enumerable mixin provides collection classes with traversal and searching methods, plus ability to sort.

describe Enumerable do

  describe "#all?{|obj|block}" do
    it "passes each element of the collection to the block; returns true if block never returns false or nil" do
      array = %w(entourage mad_men true_detective).all?{|obj| obj.length >= 7}
      expect(array).to eq(true)
    end
  end

  describe "#any?{|obj| block}" do
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

  describe "#count" do
    it "returns number of items in enum through enumeration" do
      counted = [1, 2, 2, 3, 3, 3, 3].count
      expect(counted).to eq(7)
    end

    it "when argument is given, returns number of items in enum that are equal to item" do
      counted = [1, 2, 2, 3, 3, 3, 3].count(3)
      expect(counted).to eq(4)
    end

    it "returns number of elements yielding a true value" do
      counted = [1, 2, 2, 3, 3, 3, 3].count{|x| x > 1}
      expect(counted).to eq(6)
    end
  end

  describe "#cycle(n){|obj| block}" do
    it "calls block n times or until nil is given" do
      array = [1,2,3,4].cycle(2){|x| x + x}
      expect(array).to eq(nil)
    end

    it "returns nil/nothing if collection is empty" do
      array = [1,2,3,4].cycle(0){|x| x + x}
      expect(array).to eq(nil)
    end

    it "returns nothing if non-positive number is given" do
      array = [].cycle(0){|x| x + x}
      expect(array).to eq(nil)
    end
  end

  describe "#detect(ifnone = nil) { |obj| block } → obj or nil" do
    it "returns the first for which block is not false" do
      result = (1..100).detect{|i| i%2 == 0 && i%10 ==0}
      expect(result).to eq(10)
    end

    it "returns the first item that is true" do
      result = (1..15).find{|x| x%2 == 0 && x%4 == 0}
      expect(result).to eq(4)
    end
  end

  describe "#drop(n) -> array" do
    it "drops first n elements from enum and returns rest of collection in an array" do
      result = (1..10).drop(4)
      expect(result).to eq([5, 6, 7, 8, 9, 10])
    end
  end

  describe "#drop_while{|array| block}" do
    it "drops elements up to, but not including, the first element for which the block returns false or nil" do
      array = [1,2,3,4,5,6,7,8]
      result = array.drop_while{ |i| i < 4 }
      expect(result).to eq([4,5,6,7,8])
    end
  end

  describe "#each_cons(n)" do
    it "it iterates the given block for each array of consecutive elements" do
      words = ["cats", "dogs" ,"carts", "john"].each_cons(2){|x|p x}
      expect(words).to eq(nil)
    end
  end


end