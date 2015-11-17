require 'spec_helper'

describe Array do

  describe "Adding two array objects together" do
    it "returns a new array with concatenated results" do
      array_one = [1, 2]
      array_two = [5, 6]
      concat = array_one + array_two
      expect(concat).to eq([1, 2, 5, 6])
    end
  end

  describe "#new" do
    it "returns a new array" do
      array = Array.new
      expect(array).to eq([])
    end

    it "returns a new array of 3 elements named 'object'" do
      array = Array.new(3, "object")
      expect(array).to eq(["object", "object", "object"])
    end


    it "returns a new array with passing in an array object" do
      array = ["carts", "buckets"]
      new_array = Array.new(array)
      expect(new_array).to eq(["carts", "buckets"])
    end

    it "returns a new array(size) with value from block" do
      array = Array.new(4){|index| index**2}
      expect(array).to eq([0, 1, 4, 9])
    end

    it "returns a new array when second parameter, the same parameter will be the value for array elements" do
      array = Array.new(4, {})
      expect(array).to eq([{}, {}, {}, {}])
    end
  end

  describe "#try_convert" do
    it "converts object to array" do
      array = Array.try_convert(["cats", 1])
      expect(array).to eq(["cats", 1])
    end

    it "returns nil if object cannot become an array" do
      no_array = Array.try_convert(1) #calls to_ary on object
      expect(no_array).to eq(nil)
    end
  end

  describe "&" do #set intersection
    it "returns a new array containing elements common to both array & new_array" do
      array = [1,2,3,"cats"]
      new_array = Array.new(3, "cats")
      result = array & new_array
      expect(result).to eq(["cats"])
    end
  end

  describe "ary * int -> new_array" do #repetition
    it "returns a new array built by concatenating the int copies to self" do
      array = [["cats",1], ["dogs",2], ["mice", 3]] * 3
      expect(array).to eq([["cats",1], ["dogs",2], ["mice", 3], ["cats",1], ["dogs",2], ["mice", 3], ["cats",1], ["dogs",2], ["mice", 3]])

    end
  end

  describe "ary * str -> new_string" do
  end
end