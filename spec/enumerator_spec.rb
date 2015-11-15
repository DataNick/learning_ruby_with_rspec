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

end