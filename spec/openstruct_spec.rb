require 'spec_helper'
require 'ostruct'

# Data structure similar to a hash. Defines arbitrary attributes and with their accompanying values
# Makes use of Ruby's metaprogramming to define mehtods on the class itself
# employs a hash internally to store it's methods and values

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

  describe "#[]=" do
    it "sets the value of a member" do
      person = OpenStruct.new('name' => 'John Smith', 'age' => 70)
      person[:name] = "Stuart"
      expect(person[:name]).to eq("Stuart")
    end
  end

  describe "#send method" do
    it "reaches hash keys with characters not normally reserved for methods" do
      measurements = OpenStruct.new("length (in inches)" => 24)
      send = measurements.send("length (in inches)")
      expect(send).to eq(24)
    end
  end

  describe "#delete_field" do
    it "removes the field from the object" do
      first_pet = OpenStruct.new(:name => 'Rowdy', :owner => 'John Smith')
      first_pet.delete_field(:owner)
      second_pet = OpenStruct.new(:name => 'Rowdy')
      expect(first_pet == second_pet).to eq(true)
    end
  end

  describe "#each_pair()" do
    it "Yields all attributes (as a symbol) along with the corresponding values or returns an enumerator if not block is given" do
      data = OpenStruct.new("country" => "Australia", :population => 20_000_000)
      array_of_data = data.each_pair.to_a
      expect(array_of_data).to eq([[:country, "Australia"], [:population, 20000000]])
    end
  end

  describe "#eql?(other)" do
    it "Compares this object and other for equality" do
      data = OpenStruct.new("country" => "Australia", :population => 20_000_000)
      data_2 = OpenStruct.new("country" => "Australia", :population => 20_000_000)
      result = data.eql?(data_2)
      expect(result).to eq(true)
    end
  end






end