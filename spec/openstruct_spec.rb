require 'spec_helper'
require 'ostruct'

describe OpenStruct do

  describe "#[]name" do
    it "returns value of a member" do
      person = OpenStruct.new('name' => 'John Smith', 'age' => 70)
      expect(person[:name]).to eq('John Smith')
    end
  end
end