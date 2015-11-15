require 'spec_helper'

describe Enumerator do

  describe "#each method" do
    it "returns an object of type Enumerator when a block is not passed" do
      result = %w(carts collections buckets travel).each
      expect(result.class).to eq(Enumerator)
    end
  end

end