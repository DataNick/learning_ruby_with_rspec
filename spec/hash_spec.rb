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

  describe "#key; key(value) method to return key" do
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

  describe "the #freeze method on Object class" do
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
      hash["b"] = "another_new_object"
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

end