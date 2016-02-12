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
  end

  describe "#[]name" do
    it "returns value of a member" do
      person = OpenStruct.new('name' => 'John Smith', 'age' => 70)
      expect(person[:name]).to eq('John Smith')
    end
  end
end