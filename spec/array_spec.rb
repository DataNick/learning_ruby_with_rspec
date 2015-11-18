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

  describe "#==" do
    it "returns true if two arrays contain same number of elements and each element is equal to their respective clone in the second array" do
      array = [1,2,3]
      second = [1,2,3]
      result = array == second
      expect(result).to eq(true)
    end

    it "returns false if either the number of elements don't match or each position of corresponding elements don't match" do
      array = [1,2,3]
      second = [2,1,3]
      result = array == second
      expect(result).to eq(false)
    end
  end

  describe "#ary[index]" do
    it "returns element value at given index" do
      array = [10,11,12,13,14]
      result = array[2]
      expect(result).to eq(12)
    end
  end

  describe "#ary[start,length]" do
    it "returns subarray for elements beginning at start and continuing for length elements" do
      array = ["cart", "wheel", "selection", "collection"]
      result = array[1,3]
      expect(result).to eq(["wheel", "selection", "collection"])
    end
  end

  describe "#ary[start,length]" do
    it "returns subarray for range of elements specified by index" do
      array = ["cart", "wheel", "selection", "collection"]
      result = array[0..2]
      expect(result).to eq(["cart", "wheel", "selection"])
    end
  end

  describe "#slice(index)" do
    it "is similar to array[index]" do
      array = [1,2,3,4,"cart",7,8,9,10]
      result = array.slice(4)
      expect(result).to eq("cart")
    end
  end

  describe "#slice(start,length)" do
    it "returns subarray from start and continuing for length of elements" do
      array = [1,2,3,4,"cart",7,8,9,10]
      subarray = array.slice(2,5)
      expect(subarray).to eq([3,4,"cart",7,8])
    end
  end

  describe "#slice(range)" do
    it "returns subarray for range of index" do
      array = %w(cart collect wheel bucket barrel wind grass)
      subarray = array.slice(2..5)
      expect(subarray).to eq(%w(wheel bucket barrel wind))
    end
  end

  describe "#delete_at(index)" do
    it "removes an element in array at specified index" do
      array = %w(cart wheel collect)
      result = array.delete_at(2)
      expect(result).to eq("collect")
      expect(array).to eq(%w(cart wheel))
    end

    it "returns nil if object is not found at specified index" do
      array = %w(cart wheel)
      result = array.delete_at(6)
      expect(result).to eq(nil)
    end
  end

  describe "#array[index] = obj" do
    it "sets the value/element at index" do
      array = Array.new
      value = array[4]= "cart"
      expect(array).to eq([nil, nil, nil, nil, "cart"])
    end
  end

  describe "#array[start,length]" do
    it "assigns elements beginning at start and continuing for length" do
      array = Array.new(3, "items")
      array[2, 3]= ["elements", "elements", "elements"]
      expect(array).to eq(["items", "items", "elements", "elements", "elements"])
    end
  end

  describe "#array[range]" do
    it "returns a new array by including a subarray of values specified by range" do
      array = ["cart", 2, nil, true]
      array[0,0]= ["collect", 25]
      array[-2]= "no_nil"
      expect(array).to eq(["collect",25,"cart", 2, "no_nil",true])
    end
  end

  describe "#push(obj)" do #Append
    it "appends object(s) to end of array" do
      array = [1,2,3,4]
      array.push([5,6,7,8])
      expect(array).to eq([1,2,3,4,[5,6,7,8]])
    end
  end

  describe "#unshift" do #prepend
    it "prepends objects to the front of an array" do
      array = [[1],[2]]
      array.unshift("collect")
      expect(array).to eq(["collect", [1], [2]])
    end
  end

  describe "#any?{|obj|block}" do
    it "searches the array and returns true if elements match value from block and false otherwise" do
      array = %w(cart logs command trees one at).any?{|word| word.length < 3}
      expect(array).to eq(true)
    end
  end


  describe "#assoc(obj) --> new_array or nil" do
    it "searches an array of arrays, comparing first element from each array for matching obj" do
      array = [%w(colours red yellow blue), %w(genres romance action comedy), %w(search collect select each)]
      first_element = array.assoc("colours")
      expect(first_element).to eq(%w(colours red yellow blue))
    end

    it "returns nil if searching for non-first element in array" do
      array = [%w(colours red yellow blue), %w(genres romance action comedy), %w(search collect select each)]
      first_element = array.assoc("action")
      expect(first_element).to eq(nil)
    end
  end

  describe "#at(index)" do
    it "returns element at index" do
      array = %w(carts collection barrel bucket)
      value = array.at(2)
      expect(value).to eq("barrel")
    end
  end

  # describe "#bsearch{|obj|block} --> elem" do
  #   it "returns " do
  #   end
  # end

  describe "#index(obj) --> int or nil" do
    it "searches the array and returns the first index in array that fulfills the condition where object is == to obj" do
      array = %w(cart bucket well collect barrel)
      result = array.index("bucket")
      expect(result).to eq(1)
    end

    it "returns first obj that block returns true" do
      array = %w(cart wheel barrel bucket box)
      result = array.index{|word| word.length == 5}
      expect(result).to eq(1)
    end

    it "returns an Enumerable object" do
      array = %w(cart wheel barrel bucket box)
      result = array.index.class
      expect(result).to eq(Enumerator)
    end
  end

  describe "#rindex(obj)" do
    it "returns index of last object to == obj" do
      array = %w(cart tee wheel two two two)
      result = array.rindex("two")
      expect(result).to eq(5)
    end
  end

  describe "#rindex(obj){|x|block}" do
    it "begins from the last object that returns true for block and returns last item that returns true" do
      array = %w(cart tee carts wheel two two two)
      result = array.rindex{|word| word.length == 5}
      expect(result).to eq(3)
    end
  end

  describe "#rindex" do
    it "returns an Enumerator object" do
      array = %w(cart tee carts wheel two two two)
      result = array.rindex
      expect(result.class).to eq(Enumerator)
    end
  end

  describe "#clear" do
    it "removes all elements from array" do
      array = %w(item element carts collection)
      array.clear
      expect(array).to eq([])
    end
  end

  describe "#collect{|item| block} --> new_array" do
    it "returns new array containing values returned by block" do
      collect = %w(cart jug wheel).collect{|word| word.chars[0] == "c"}
      expect(collect).to eq([true, false, false])
    end

    it "invokes given block once for each element in self" do
      collect = %w(cart jug wheel).collect{|word| word + "!"}
      expect(collect).to eq(%w(cart! jug! wheel!))
    end

    it "returns an Enumerator" do
      collect = %w(cart wheel).collect
      expect(collect.class).to eq(Enumerator)
    end
  end

  describe "#collect! --> array" do
    it "invokes given block once for each element; replacing each element with the value returned by block" do
      collect = %w(cart wheel).collect!.with_index{|value, index| value[0..index]}
      expect(collect).to eq(["c","wh"])
    end
  end

  describe "#combination(n)" do
    it "yields all combinations of length n of elements from array and returns array" do
      array = [1,2,3,4,5,6]
      result = array.combination(5).to_a
      expect(result).to eq([[1,2,3,4,5],[1,2,3,4,6],[1,2,3,5,6],[1,2,4,5,6],[1,3,4,5,6],[2,3,4,5,6]])
    end
  end

  describe "#compact! > new_array" do
    it "returns a new array with all nil values removed" do
      array = [1,2,"cart",true,nil,false,nil]
      array.compact!
      expect(array).to eq([1,2,"cart",true,false])
    end
  end

  describe "#concat(other_array) > array" do
    it "adds two arrays together" do
      array = %w(cart bucket)
      other_array = [1,2,3]
      array.concat(other_array)
      expect(array).to eq(["cart", "bucket", 1,2,3])
    end

    it "uses + to add arrays together" do
      array = %w(cart bucket)
      other_array = [1,2,3]
      another_array = %w(well collect)
      result = array + other_array + another_array
      expect(result).to eq(["cart", "bucket", 1,2,3, "well", "collect"])
    end
  end

  describe "#count" do
    it "counts the number of elements in the array" do
      array = [1, 2, 3, "cart", "wheel", nil, true, false]
      expect(array.count).to eq(8)
    end

    it "counts the number of objects in argument" do
      array = [1, 2, 3, "cart", "wheel", nil, true, false, 1, 1]
      expect(array.count(1)).to eq(3)
    end

    it "counts the number of objects for which block returns true" do
      array = %w(one two three four five six seven eight nine ten)
      result = array.count{|word| word.length%3 == 0}
      expect(result).to eq(4)
    end
  end

  describe  "#cycle(n){|obj|block}" do
    it "calls the block for each item in the collection n times and returns nil" do
      a = %w(trucks one two three ten)
      result = a.cycle(2){|x| puts x%3==0}
      expect(result).to eq(nil)
    end
  end

  describe "#delete(obj)" do
    it "removes element == obj from array" do
      array = %w(cart one two three)
      array.delete("cart")
      expect(array).to eq(%w(one two three))
    end

    it "returns the object that was deleted from array" do
      array = %w(cart one two three)
      var = array.delete("cart")
      expect(var).to eq("cart")
    end

    it "returns value from the block if item is not found" do
      array = %w(cart wheel collect)
      result = array.delete("two"){"not found"}
      expect(result).to eq("not found")
    end
  end

  describe "#delete_if{|item|block}" do
    it "removes every element for which block returns true" do
      a = %w(cart wheel barrel bucket well)
      a.delete_if{|word| word.size == 4}
      expect(a).to eq(%w(wheel barrel bucket))
    end
  end

  describe "#drop(n)" do
    it "removes first n elements and returns a new array" do
      a = %w(cart wheel bucket well barrel box)
      result = a.drop(4)
      expect(result).to eq(%w(barrel box))
    end
  end

  describe "#drop_while{|arr|block}" do
    it "removes elements up to the first element for which block returns nil or false" do
      a = %w(cart cage wheel bucket well barrel box) #only cart & cage will be removed
      result = a.drop_while{|x| x.length == 4}
      expect(result).to eq(%w(wheel bucket well barrel box))
    end
  end

  describe "#each{|item|block}" do
    it "returns an enumerator object when called without a block" do
      a = %w(cart wheel log collect)
      result = a.each
      expect(result.class).to eq(Enumerator)
    end

    it "calls block once for each element in collection" do
      a = []
      v = [1,2,3,4]
      result = v.each{|x| a << x*2}
      expect(a).to eq([2,4,6,8])
    end

    it "returns an Enumerator object when called without a block" do
      v = [1,2,3,4]
      result = v.each
      expect(result.class).to eq(Enumerator)
    end
  end

  describe "#each_index{|index|block}" do
    it "passes index of element instead of element" do
      a = []
      v = %w(cart barrel log collect)
      v.each_index{|i| a << i*2}
      expect(a).to eq([0,2,4,6])
      expect(v.each.class).to eq(Enumerator)
    end
  end

  describe "#empty?" do
    it "returns true if array has no elements" do
      v = Array.new
      expect(v.empty?).to eq(true)
    end

    it "returns false if array has elements" do
      v = Array.new(2, "items")
      expect(v.empty?).to eq(false)
    end
  end

  describe "#eql?(other_array)" do
    it "returns true if array and other array are same or conatain same content" do
      v = [1,2,3]
      x = [1,2,3]
      result = v.eql?(x)
      expect(result).to eq(true)
    end

    it "returns false if self and other are different objects" do
      v = [1,2,3]
      x = [1,4,3]
      result = v.eql?(x)
      expect(result).to eq(false)
    end
  end

  describe "#fetch(index)" do
    it "returns element from specified index" do
      a = [1, 2, nil, "cart"]
      result = a.fetch(3)
      expect(result).to eq("cart")
    end
  end

end