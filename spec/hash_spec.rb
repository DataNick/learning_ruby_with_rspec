require 'spec_helper'

describe Hash do

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

end