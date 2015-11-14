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

  describe "#chunk{|elt|block}" do
    it "Enumerates over each element, joining them together based on return value of block; consecutive elements returning same value are joined together" do
      people = [ { :house => 'Targaryen', :name => 'The Mother of Dragons' }, { :house => 'Targaryen', :name => 'Aerys "The Mad King"' }, { :house => 'Lannister', :name => 'Jaime "Kingslayer" Lannister' }, { :house => 'Lannister', :name => 'Cersei Lannister' }, { :house => 'Stark', :name => 'Jon Snow' }, { :house => 'Stark', :name => 'Maester Luwin' }, { :house => 'Stark', :name => 'Ned Start' }]
      result = people.chunk {|person| person[:house]}.each do |house, members|
        names = members.map {|m| m[:name]}
        puts "#{names} swear allegiance to House #{house}."
      end
      expect(result).to eq(nil)
    end
  end

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

  describe "#flat_map{|obj| block}" do
    it "returns new array with concatenated results" do
      result = [[1],[2],[3],[4]].flat_map{|x| x + [100]}
      expect(result).to eq([1,100,2,100,3,100,4,100])
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

  describe "#find" do
    it "for an array, passes in obj and returns first item for which block is not false" do
      result = [1,2,3,"cats"].find{|x| x == "cats"}
      expect(result).to eq("cats")
    end

    it "passes key and value to the block for a hash" do
      result = {a: 12, b: 15}.find{|key, value| key == :b} #=> [:b, 15]
      expect(result).to eq([:b, 15])
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

  describe "#each_entry{|obj| block} --> enum" do
    it "calls block once for each element in self" do
      result = [1,2,3,4].each_entry{|x|if x%2 == 0 then p "the key is #{x}" end}
      expect(result).to eq([1,2,3,4])
    end
  end

  describe "#each_slice(n){|obj| block}" do
    it "iterates the given block for each slice of n elements" do
      results = (1..11).each_slice(3) { |a| p a }
      expect(results).to eq(nil)
    end
  end

  describe "#each_with_index(args){|item, index| block}" do
    it "calls block with object and it's index" do
      hash = Hash.new
      result = %w(zero one two three four).each_with_index{|obj, i| hash[i] = obj}
      expect(hash).to eq({0 => "zero", 1 => "one", 2 => "two", 3 => "three", 4 => "four"})
    end

    it "returns only items with index divisible by 2" do
      array = []
      result = [1,2,3,4,5,6].each_with_index{|number, index| index%2 == 0 ? array.push(number) : number}
      expect(array).to eq([1,3,5])
      expect(result).to eq([1,2,3,4,5,6])
    end
  end

  describe "#each_with_object(obj) {|(*args), memo_obj| block} → obj" do
    it "iterates the block for each element with an object given; returns the initially given object" do
      result = %w(cats dogs hamsters).each_with_object([]){|i, a| a << i*2}
      expect(result).to eq(["catscats", "dogsdogs", "hamstershamsters"])
    end
  end

  describe "#find_all{|obj|block}" do
    it "returns array containing all items for which block returns true" do
      result = %w(cats ti art rails t).find_all{|i| i.size <= 3}
      expect(result).to eq(%w(ti art t))
    end
  end

  describe "#find_index(value) / #find_index{|obj|block}" do
    it "compares each entry in enum with value; returns index for first item evaluated as non-false" do
      result = %w(art call tree house master).find_index("tree")
      expect(result).to eq(2)
    end

    it "compares each entry in enum and passes to block; returns index for first item for which value is evaluated as non-false" do
      result = %w(breaking cast away bad).find_index{|o| o.size > 3 && o.size < 5}
      expect(result).to eq(1)
    end
  end

  describe "#first; #first(n)" do
    it "returns first element in enumerable" do
      result = (1..100).first
      expect(result).to eq(1)
      expect(result.class).to eq(Fixnum)
    end

    it "returns first n elements in enumerable" do
      result = (1..100).first(16)
      expect(result).to eq([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16])
      expect(result.class).to eq(Array)
    end
  end

  describe "#grep(pattern){|obj|block}" do
    it "returns an array of every element in enum for which pattern === element" do
      result = [1,2,3,4].grep 1..3
      expect(result).to eq([1,2,3])
    end

    it "matching elements passed to block with result stored in output array" do
      array = []
      result = [1,2,3,4].grep(1..3){|x| array << x*2}
      expect(result).to eq([[2,4,6], [2,4,6], [2,4,6]])
    end
  end

  describe "#group_by{|obj| block}" do
    it "groups collection by result of block" do
      birds = %w(robin bluejay cardinal)
      sorted = birds.sort
      result = sorted.group_by{|bird| bird.chars.last}
      expect(result).to eq({"y" => ["bluejay"], "l" => ["cardinal"], "n" => ["robin"]})
    end
  end

  describe "#include?" do
    it "returns boolean" do
      var_f = (1..10).include?(12)
      var_t = (1..10).include?(10)
      expect(var_f).to eq(false)
      expect(var_t).to eq(true)
    end
  end

  describe "#inject(initial, symbol)" do
    it "combines all elements of enum by applying binary operation, specified by block or symbol" do
      result = [2, 4, 6, 8].inject(12, :+) #2+4+6+8+12 = 32
      expect(result).to eq(32)
    end
  end

  describe "#inject(sym)" do
    it "adds all items in enum plus" do
      result = (1..10).inject(:+)
      expect(result).to eq(55)
    end
  end

  describe "#inject(initial) { |result, obj| block }" do
    it "returns the final value of memo which is return value for the method." do
      hash = [[1, "cars"], [2, "dogs"]].inject({}) do |result, element|
        result[element.last] = element.first
        result
      end
      expect(hash).to eq({"cars" => 1, "dogs" => 2})
    end
  end

  describe "#inject { |result, obj| block }" do
    it "iterates through each element in enum;  the block is passed an accumulator value (memo) and the element" do
      result = (1..10).inject{|result, element| result += element}
      expect(result).to eq(55)
    end
  end

  # describe "#lazy" do
  #   it "returns a lazy enumerator" do
  #   end
  # end

  describe "#map{|obj| block}" do
    it "returns a new array with results of running the block once for each element" do
      new_array = %w(dogs deers)
      result = %w(cats cars struck).map{|obj| new_array.push(obj)}
      expect(result).to eq([["dogs", "deers", "cats", "cars", "struck"], ["dogs", "deers", "cats", "cars", "struck"], ["dogs", "deers", "cats", "cars", "struck"]])
    end
  end

  describe "#max{|obj| block}" do
    it "returns the object in enum with the maximum value" do
      result = %w(albatross dog horse cat deers).max{|a, b| a.length <=> b.length}
      expect(result).to eq("albatross")
    end

    it "returns max word in list" do
      result = %w(ant cats zebra).max
      expect(result).to eq("zebra")
    end
  end

  describe "#max_by{|obj| block}" do
    it "returns object in enum that gives max value from block" do
      result = %w(albatross marks cross you).max_by{|obj| obj.chars.sort.join }
      expect(result).to eq("you")
    end
  end

  describe "member?(obj)" do
    it "returns true if any member in enum equals obj" do
    result = %w(art object grass).member?("grass")
    expect(result).to eq(true)
    end
  end

  describe "#min method" do
    it "returns obj in enum with min value" do
      result = %w(cars stuff objects).min
      expect(result).to eq("cars")
    end

    it "returns minimum value from the given block" do
      result = %w(cars stuff objects).min{|a, b| b.length <=> a.length}
      expect(result).to eq("objects")
    end
  end

  describe "#min_by{|obj| block}" do
    it "returns object in enum that gives min value from given block" do
      result = %w(cars stuff objects).min{|obj| obj.size }
      expect(result).to eq("cars")
    end
  end

  describe "#minmax" do
    it "returns a two element array that contain min and max values from enum collection" do
      result = %w(albatross cars discuss).minmax
      expect(result).to eq(["albatross", "discuss"])
    end

    it "returns two element array that contains the min and max values" do
      result = %w(albatross cars discuss you).minmax{|a, b| a.chars.sort.join <=> b.chars.sort.join}
      expect(result).to eq(["albatross", "you"])
    end
  end

  describe "#none?{|obj| block}" do
    it "returns true if block never returns true for all elements" do
      result = %w(cars zebra donkey).none?{|obj| obj.length >= 7}
      expect(result).to eq(true)
    end

    it "returns false if block ever returns true" do
      result = %w(art charters running).none?{|obj| obj.length == 3}
      expect(result).to eq(false)
    end
  end

  describe "#one?{|obj| block}" do
    it "returns true if block returns true exactly once" do
      result = %w(art house fun times).one?{|obj| obj.length == 3}
      expect(result).to eq(false)
    end
  end

  describe "#partition{|obj| block}" do
    it "returns two arrays, the first containing the elements of enum for which block returns true; the second containg elements for which the block returns false" do
      result = %w(cars tree albatross horses).partition{|obj| obj.length < 5 }
      expect(result).to eq([["cars", "tree"],["albatross", "horses"]])
    end

    it "returns two arrays" do
      animals = [ {animal: "cat", role: "pet"}, {animal: "dog", role: "pet"}, {animal: "horse", role: "worker"}, {animal: "donkey", role: "worker"}, {animal: "pig", role: "food"}, {animal: "chicken", role: "food"}, {animal: "hamster", role: "pet"}, {animal: "sheep", role: "worker"}]
      result = animals.partition{|animal| animal[:role] == "pet"}
      expect(result[0][1]).to eq({animal: "dog", role: "pet"})
    end
  end

  describe "#reduce(initial, sym)" do
    it "combines all elements in enum by applying a binary operation; block or symbol names a method or operator" do
      results = (1..5).reduce(1, :+)
      expect(results).to eq(16)
    end
  end

  describe "#reduce(sym)" do
    it "combines all elements in enum by applying a binary operation" do
      results = (5..10).reduce(2, :*)
      expect(results).to eq(302400)
    end
  end

  describe "#reduce(initial){|memo, obj| block}" do
    it "" do
      results = (5..10).reduce(2){|memo, obj| memo * obj}
      expect(results).to eq(302400)
    end
  end

  describe "#reduce { |memo, obj| block }" do
    it "returns the value of memo from the block" do
      results = %w(horse cheetah tiger).inject{|memo, element| memo.length > element.length ? memo : element}
      expect(results).to eq(results)
    end
  end

  describe "reject" do
    it "returns a new array for which block returns false" do
      result = (1..10).reject{|x| x.odd? }
      expect(result).to eq([2,4,6,8,10])
    end
  end

  describe "#reverse_each(*args){|item|block}" do
    it "builds temporary array and traverses it in reverse order" do
      result = (1..15).reverse_each{|x| p x if x%2 == 0}
      expect(result).to eq(1..15)
    end
  end

  describe "#select{|obj| select}" do
    it "returns new array with all elements from enum for which block returns true" do
      result = %w(cats trees horses albatross).select{|word| word.length > 5}
      expect(result).to eq(%w(horses albatross))
    end
  end

  describe "#sort; #sort{|a,b|block}" do
    it "returns array containing sorted items" do
      result = %w(cars john trees deer albatross).sort
      expect(result).to eq(%w(albatross cars deer john trees))
    end

    it "returns result of block" do
      result = %w(cars john trees deer albatross).sort{|a, b| a.length <=> b.length}
      expect(result).to eq(%w(cars john deer trees albatross))
    end
  end

  describe "#sort_by{|obj| block}" do
    it "generates an array of tuples containing original collection element and mapped value" do
      result = %w(cars racecar mastery knowledge).sort_by{|obj| obj.chars.sort.join}
      expect(result).to eq(%w(racecar cars mastery knowledge))
    end
  end

  describe "#take(n)" do
    it "takes first n elements from array" do
      result = %w(tree racecar master knee).take(3)
      expect(result).to eq(%w(tree racecar master))
    end
  end

  describe "#take_while{|array| block}" do
    it "passes elements to the block until nil or false is returned, then stops and returns array of prior elements" do
      results = ["cars", "race", true, nil, "create" ].take_while{|x| x}
      #it prints up to nil but returns element(s) prior to nil
      expect(results).to eq(["cars", "race", true])
    end
  end
end