require 'spec_helper'
require 'ostruct'

# Data structure similar to a hash. Defines arbitrary attributes and with their accompanying values
# Makes use of Ruby's metaprogramming to define mehtods on the class itself

describe OpenStruct do

  describe "making a new OpenStruct object" do
    it "takes a hash object as an argument" do
      hash = {name: "Harry", age: 45, country: "USA"}
      data = OpenStruct.new(hash)
      expect(data[:name]).to eq("Harry")
    end

    it "calls the new method to create a new OpenStruct object" do
      person = OpenStruct.new(name: "name", age: "has an age", height: "that, too", weight: "well, duh")
      expect(person[:weight]).to eq("well, duh")
    end

    it "can re-write values of keys" do
      person = OpenStruct.new(name: "name", age: "has an age", height: "that, too", weight: "well, duh")
      person[:name] = "Charles"
      expect(person[:name]).to eq("Charles")
    end
  end

  describe "#[]name" do
    it "returns value of a member" do
      person = OpenStruct.new('name' => 'John Smith', 'age' => 70)
      expect(person[:name]).to eq('John Smith')
    end
  end
end