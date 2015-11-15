require 'spec_helper'

describe Enumerator do

  describe "#each method" do
    it "returns an object of type Enumerator when a block is not passed" do
      result = %w(carts collections buckets travel).each
      expect(result.class).to eq(Enumerator)
    end
  end

  describe "#new; constructing Enumerable object (Enumerator) from scratch" do
    it "builds the fibonacci sequence" do
      fib = Enumerator.new do |y|
        a = b = 1
        loop do
          y << a
          a, b = b, a + b
        end
      end
      result = fib.first(5)
      expect(result).to eq([1,1,2,3,5])
    end
  end

  describe "#each" do
    it "iterates over block based on how Enumerator is constructed" do
      enum = %w(cart bucket collect).to_enum #gives an Enumerator object with each as default method
      result = enum.each_with_index.to_a
        expect(result).to eq([["cart", 0], ["bucket", 1], ["collect", 2]])
    end
  end

  describe "#each_with_index" do
    it "returns an array with the element and key position from collection" do
      enum = %w(cart bucket rails ruby).to_enum :each_with_index
      first = enum.first
      expect(first).to eq(["cart", 0])
    end
  end

  describe "#each_with_object" do
    it "returns a collection in reverse order" do
      enum = %w(cart basket bucket).to_enum :map
      result = enum.each_with_object("collect").to_h
      expect(result).to eq({"cart" => "collect", "basket" => "collect", "bucket" => "collect"})
    end
  end

  describe "#inspect" do
    it "presents a printable version of enum" do
      enum = [1, 2, 3].to_enum
      result = enum.first.inspect
      expect(result).to eq("1")
    end
  end

  describe "#next" do
    it "returns the next value in the collection/enumerator" do
      enum = %w(collect next word from the list).to_enum
      next_word = enum.next
      expect(next_word).to eq("collect")
    end
  end

end