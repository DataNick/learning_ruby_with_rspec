require 'spec_helper'

describe Hash do

  describe "Hash constructor" do
    it "calls a block with hash object and key" do
      hash = Hash.new{|hash, key| hash[key] = "The key is #{key}"}
      letter = hash["c"]
      number = hash[12]
      expect(letter).to eq("The key is c")
      expect(number).to eq("The key is 12")
      expect(hash).to eq({"c" => "The key is c", 12 => "The key is 12"})
    end
  end

  describe "#== [other hash]" do
    it "returns true if other hash has exact same keys and values" do
      h1 = {b: 3, a: 2}
      h2 = {a: 2, b: 3}
      result = (h1 == h2)
      expect(result).to eq(true)
    end

    it "returns false if other hash has different keys and values" do
      h1 = {a: 2, b: 3}
      h2 = {a: 2, c: 3}
      result = (h1 == h2)
      expect(result).to eq(false)
    end
  end

  describe "#[]; hsh[key] -> value in hash" do
    it "returns value from the key" do
      h1 = { car: "fast", wheels: 4, doors: "four"}
      result = h1[:wheels]
      expect(result).to eq(4)
    end
  end

  describe "#[]=; hsh[key] = value -> value" do
    it "associates the value given by value with the key given by key" do
      h = { "a" => 100, "b" => 200 }
      h[:c] = 9
      h["a"] = 1
      expect(h).to eq({ "a" => 1, "b" => 200, c: 9 })
    end
  end

  describe "#store(key, value) -> value" do
    it "associates the value given by value with the key given by key" do
      h = { "a" => 100, "b" => 200 }
      h.store("c", 455)
      h.store("b", 300)
      expect(h).to eq({ "a" => 100, "b" => 300, "c" => 455 })
    end
  end

  describe "#key; #key(value) method to return key" do
    it "returns the key of an occurrence of a given value" do
      h = { a: 100, b: 200, c: 300, d:400 }
      var = h.key(100)
      expect(var).to eq(:a)
    end

    it "returns nil if value is not found" do
      h = { a: 100, b: 200, c: 300, d:400 }
      var = h.key(500)
      expect(var).to eq(nil)
    end
  end

  describe "#key?(key) method" do
    it "returns true if given key is present in hash" do
      hash = {"a" => 12, "sea" => 23, "dee" => 34}
      key = hash.key?("a")
      expect(key).to eq(true)
    end
  end

  describe "#any? for Enumerable" do
    it "ensure the method returns true for object" do
      h = { a: 100, b: "wheels", c: 300 }
      value = h.any?{|key, value| key == :c}
      expect(value).to eq(true)
    end

    it "ensure the method returns false for value of nil" do
      h = {a: 1, b: 2 }
      value = h.any?{|key, value| (value % 2) == 0 }
      expect(value).to eq(true)
    end
  end

  describe "#freeze method on Object class" do
    it "ensure an unfrozen object is duplicated" do
      a = "a"
      b = "b".freeze
      h = { a => 100, b => 200 }
      object_id = h.key(100).equal? a
      expect(object_id).to eq(false)
    end

    it "ensure frozen object is not duplicated" do
      a = "a"
      b = "b".freeze
      h = { a => 100, b => 200 }
      object_id = h.key(200).equal? b
      expect(object_id).to eq(true)
    end
  end

  describe "#assoc(obj) method" do
    it "searches through the hash comparing obj with the key using ==" do
      h = {"colors"  => ["red", "blue", "green"], "letters" => ["a", "b", "c" ]}
      result = h.assoc("colors")
      expect(result).to eq(["colors", ["red", "blue", "green"]])
    end

    it "returns type array" do
      h = {"colors"  => ["red", "blue", "green"], "letters" => ["a", "b", "c" ]}
      result = h.assoc("letters")
      expect(result.class).to eq(Array)
    end

    it "returns nil if no match is found" do
      h = {"colors"  => ["red", "blue", "green"], "letters" => ["a", "b", "c" ]}
      result = h.assoc("countries")
      expect(result).to eq(nil)
    end
  end

  describe "#flatten" do
    it "returns a one-dimensional array" do
      hash = {:a => 12, :b => "cars", :c => "wheels"}
      array = hash.flatten
      expect(array).to eq([:a, 12, :b, "cars", :c, "wheels"])
    end
  end

  describe "#clear method" do
    it "removes all key/value pairs from an hash" do
      hash = {a: 200, cars: "four", wheels: 4}
      hash.clear
      expect(hash).to eq({})
    end
  end

  describe "#compare_by_identity returns a hash" do
    it "makes hsh compare its keys by their identity" do
      hash = {"a" => 100, "b" => "letter", c: "symbol", 12 => "number"}
      before_compare = hash.compare_by_identity?
      hash.compare_by_identity
      after_compare = hash.compare_by_identity?
      hash[:c] = "rewritting_value"
      hash[12] = "rewritting_value"
      hash["a"] = "new_object"
      expect(hash["a"]).to be_nil
      expect(hash.key(100)).to eq("a")
      expect(hash.key("new_object")).to eq("a")
      expect(hash[:c]).to eq("rewritting_value")
      expect(hash.key("symbol")).to be_nil
    end
  end

  describe "#default(key = nil) method" do
    it "returns the default value" do
      hash = Hash.new("cars")
      expect(hash.default).to eq("cars")
    end

    it "Returns the the value that would be returned by hsh if key did not exist in hsh." do
      hash = Hash.new("cars")
      expect(hash[:c]).to eq("cars")
      expect(hash).to eq({})
      expect(hash.default).to eq("cars")
    end
  end

  describe "#default = obj returns object" do
    it "sets value for keys that don't exist" do
      hash = {a: 12, b: "wheels"}
      hash.default = "no value"
      expect(hash[:c]).to eq("no value")
    end
  end

  describe "#default_proc returns an object" do
    it "returns block if block invoked with hash constructor" do
      h = Hash.new {|h,k| h[k] = k*k }
      p = h.default_proc
      a = []
      p.call(a,2)
      p.call(a,5)
      expect(a).to eq([nil, nil, 4, nil, nil, 25])
    end
  end

  describe "#default_proc= proc_object" do
    it "returns the proc object" do
      h = Hash.new {|h,k| h[k] = "The key is #{k}" }
      h.default_proc = proc do |hash, key|
        hash[key] = "The key in the proc is #{key}"
      end
      expect(h[3]).to eq("The key in the proc is 3")
      expect(h["wheels"]).to eq("The key in the proc is wheels")
    end
  end

  describe "#delete(key) returns value" do
    it "returns value of deleted key or nil if key is not found" do
      h = {a: 12, b: 14, c: 16}
      value = h.delete(:a)
      no_value = h.delete(:d)
      expect(value).to eq(12)
      expect(no_value).to eq(nil)
    end

    it "returns result of block if key is not found" do
      h = { "a" => 100, "b" => 200 }
      no_value = h.delete("z") { |el| "#{el} not found" }
      value = h.delete("b") { |el| "#{el} not found" }
      expect(no_value).to eq("z not found")
      expect(value).to eq(200)
    end
  end

  describe "#delete_if" do
    it "returns an enumerator object when no block is called" do
      h = { "a" => 100, "b" => 200, "c" => 300 }
      enum = h.delete_if
      expect(enum.class).to eq(Enumerator)
    end

    it "returns a hash when a block is passed" do
      h = { "a" => 100, "b" => 200, "c" => 300 }
      result = h.delete_if{|key, value| value == 100}
      expect(result).to eq({ "b" => 200, "c" => 300 })
    end
  end

  describe "#each method" do
    it "returns hash when passing a block" do
      hash = { a: 12, b: "wheels", c: "cars" }
      array = []
      result = hash.each{ |key, value| array << [key,value] }
      expect(array).to eq([[:a, 12], [:b, "wheels"], [:c, "cars"]])
      expect(result.class).to eq(Hash)
    end

    it "returns an enumerator object when no block is passed" do
      hash = { a: 12, b: "wheels", c: "cars" }
      result = hash.each
      expect(result.class).to eq(Enumerator)
    end
  end

  describe "#each_pair method" do
    it "calls block once for each key passed in hash" do
      hash = { a: 12, b: "wheels", c: "cars" }
      result = hash.each{|key, value| puts "#{key} is #{value}"}
      expect(result).to eq(hash)
      expect(result.class).to eq(Hash)
    end

    it "returns an enumerator object when no block is passed" do
      hash = { a: 12, b: "wheels", c: "cars" }
      result = hash.each_pair
      expect(result.class).to eq(Enumerator)
    end
  end

  describe "#each_key method" do
    it "calls block for each key in hash" do
      hash = { "a" => 12, "b" => 24 }
      array = []
      result = hash.each_key{|key| array << key}
      expect(array).to eq(["a", "b"])
    end
  end

  describe "#each_value method" do
    it "calls block once for each key in hash, passing in value as parameter" do
      array = []
      hash = {b: 12, c: 3, d: 5}
      result = hash.each_value{|value| array << value * value}
      expect(array).to eq([144, 9, 25])
    end
  end

  describe "#empty method" do
    it "returns true if hash contains no key-value pairs" do
      hash = {}
      expect(hash.empty?).to eq(true)
    end
  end

  describe "#eql? method" do
    it "returns true if two hashes contain same content" do
      hash = {"wheels" => 12, c: 24}
      second_hash = {c: 24, "wheels" => 12}
      result = second_hash.eql?(hash)
      expect(result).to eq(true)
    end
  end

  describe "#fetch method" do
    it "returns a value from the hash for the given key" do
      hash = {t: "cats", a: "dogs"}
      result = hash.fetch(:t)
      expect(result).to eq("cats")
    end

    it "returns default value for key" do
      hash = {}
      result = hash.fetch(2, "value")
      expect(result).to eq("value")
    end

    it "returns a block" do
      hash = {}
      result = hash.fetch(:a){|value| "checking the #{value}"}
      expect(result).to eq("checking the a")
    end
  end

  describe "#has_key?(key)" do
    it "returns a boolean" do
      hash = {a: 12, b: 15, c: 54}
      result = hash.has_key?(:a)
      expect(result).to eq(true)
      expect(hash.has_key?(:s)).to eq(false)
    end
  end

  describe "#include?(key)" do
    it "returns true if a given key is present in hash" do
      hash = {a: 12, cats: "four"}
      key = hash.include?(:a)
      no_key = hash.include?(:dogs)
      expect(key).to eq(true)
      expect(no_key).to eq(false)
    end
  end

  describe "#has_value?" do
    it "returns a boolean" do
      hash = {a: 12, b: 15, c: 54}
      result = hash.has_value?(54)
      expect(result).to eq(true)
    end
  end

  describe "#hash" do
    it "computes a hash-code as a fixnum" do
      hash = {a: 12, b: 15, c: 54}
      fixnum = hash.hash
      expect(fixnum.class).to eq(Fixnum)
    end

    it "returns same hash-code with two hashes having same content" do
      hash = {a: 12, b: 15, c: 54}
      second_hash = {c: 54, a: 12, b: 15}
      result = hash.hash == second_hash.hash
      expect(result).to eq(true)
    end
  end

  describe "#to_s method" do
    it "wraps hash inside a string" do
      hash = {a: 12, b: 15, c: 54}
      string = hash.to_s
      expect(string).to eq("{:a=>12, :b=>15, :c=>54}")
    end
  end

  describe "#inspect method" do
    it "returns contents of hash in string form" do
      hash = {a: 12, b: 15, c: 54}
      string = hash.inspect
      expect(string).to eq("{:a=>12, :b=>15, :c=>54}")
    end
  end

  describe "#invert" do
    it "returns a new hash using original hash's values as keys and the keys as values" do
      hash = {c: "cars", "s" => 12, 12 => "wheels"}
      inverted = hash.invert
      expect(inverted).to eq({"cars" => :c, 12 => "s", "wheels" => 12})
    end
  end

  describe "#keep_if{|key,value| block}" do
    it "deletes every key-value pair from hsh for which block evaluates to false" do
      hash = {a: 12, b: 2, c: 5, d: 25}
      over_ten = hash.keep_if{|key, value| value > 10 }
      expect(over_ten).to eq({a: 12, d: 25})
    end

    it "returns an enumerator if evaluated without a block" do
      hash = {a: 12, b: 2, c: 5, d: 25}
      enum = hash.keep_if
      expect(enum.class).to eq(Enumerator)
    end
  end

  describe "#keys" do
    it "returns an array of only the keys" do
      hash = {"a" => 23, "sea" => 12, dee: "cars", :eff => "trees"}
      array = hash.keys
      expect(array).to eq(["a", "sea", :dee, :eff])
    end
  end

  describe "#length" do
    it "returns the number of key-value pairs in hash" do
      hash = {"a" => 12, "b" => 24, d: 45}
      length = hash.length
      expect(length).to eq(3)
    end
  end

  describe "#member?()key" do
    it "returns true if given key is present in hash" do
      hash = {a: 12, b: 16, c: 87}
      member = hash.member?(:d)
      expect(member).to eq(false)
    end
  end

end