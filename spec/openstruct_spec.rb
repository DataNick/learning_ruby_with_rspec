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

  describe "#hash()" do
    it "computes a hash code for an OpenStruct object" do
      data = OpenStruct.new("country" => "Australia", :population => 20_000_000)
      hash_data = data.hash()
      expect(hash_data.class).to eq(Fixnum)
    end
  end

    describe "#inspect" do
      it "returns a string with a detailed summary of keys and values" do
        person = OpenStruct.new('name' => 'John Smith', 'age' => 70)
        string = person.inspect
        expect(string).to eq("#<OpenStruct name=\"John Smith\", age=70>")
      end
    end

    describe "#to_s" do
      it "returns a string with a detailed summary of keys and values" do
        person = OpenStruct.new('name' => 'John Smith', 'age' => 70)
        string = person.to_s
        expect(string).to eq("#<OpenStruct name=\"John Smith\", age=70>")
      end
    end

    describe "#marshal_dump" do
      it "marshal_dump must return a result containing the information necessary for marshal_load to reconstitute the object" do
        data = OpenStruct.new('name' => 'John Smith', 'age' => 70)
        expect(data.marshal_dump).to eq({name: 'John Smith', age: 70})
      end
    end

    describe "#marshal_load" do
      it "is called with the result from marshal_dump. marshal_load must recreate the object from the information in the result" do
        data = OpenStruct.new('name' => 'John Smith', 'age' => 70)
        data_new = OpenStruct.new #empty object
        marshal_dump_hash = data.marshal_dump
        data_new.marshal_load(marshal_dump_hash)
        expect(data_new.inspect).to eq("#<OpenStruct name=\"John Smith\", age=70>")
      end
    end

    describe "#to_h" do
      it "converts OpenStruct object to a hash object" do
        os_object = OpenStruct.new(name: "Josh", age: 24, occupation: "Steelworker", location: "Pennsylvania")
        hash = os_object.to_h()
        expect(hash).to eq({name: "Josh", age: 24, occupation: "Steelworker", location: "Pennsylvania"})
      end
    end

end