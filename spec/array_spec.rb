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
    it "returns a new string with str separated by a given separator" do
      array = [1,2,3]*", object, "
      expect(array).to eq("1, object, 2, object, 3")
    end
  end

  describe "#join" do
    it "returns a new string by joining array object with string object" do
      array = Array.new(3, "object")
      joined = array.join
      expect(joined).to eq("objectobjectobject")
    end

    it "returns a string separated by a given #join(separator = $)" do
      array = ["items"]*3
      new_string = array.join(", joined, ")
      expect(new_string).to eq("items, joined, items, joined, items")
    end
  end

  describe "array + another_array = new_array" do
    it "returns a new array by concatenating two or more arrays" do
      array = Array.new(2, "items")
      another_array = [1,2,3]
      result = array + another_array
      expect(result).to eq(["items", "items", 1, 2, 3])
    end
  end

  describe "array - another_array" do
    it "returns a new array without any items that also appear in another_array" do
      array = [1,2,3,4,"cats", "dogs", "mice"]
      another_array = [1,2,"dogs"]
      result = array - another_array
      expect(result).to eq([3,4,"cats","mice"])
      expect(another_array - array).to eq([])
    end
  end

  describe "<< pushes/append method" do
    it "Pushes new object to the end of the array and returns appended array" do
      array = [1,2,3] << "cats" << "carts"
      expect(array).to eq([1,2,3,"cats", "carts"])
    end
  end

  describe "#<=> comparison" do
    it "returns 1 if first array is greater than second array" do
      array = [1,2,3]
      second = [1]
      result = array <=> second
      expect(result).to eq(1)
    end

    it "returns 0 if first and second arrays have same number of elements" do
      array = ["cart", "bucket", "collect"]
      second = ["cart", "bucket", "collect"]
      result = array <=> second
      expect(result).to eq(0)
    end

    it "returns -1 if first array is less than second array" do
      array = [1]
      second = [1,2,3]
      result = array <=> second
      expect(result).to eq(-1)
    end

    it "returns an array of all 1s as less than an array of all 2s" do
      array = [1,1,1]
      second = [2,2,2]
      result = array <=> second
      expect(result).to eq(-1)
    end

    it "returns an array of letters after comparing the first element of array1 with first element of array2 and so on" do
      array = ["a", "b", "c", "d"]
      second = ["a","a","b","c"]
      result = array <=> second
      expect(result).to eq(1)
    end
  end

end