require 'spec_helper'
# Enumerable mixin provides collection classes with traversal and searching methods, plus ability to sort.

describe Enumerable do

  describe "#all?{|obj|block}" do
    it "passes each element of the collection to the block; returns true if block never returns false or nil" do
      array = %w(entourage mad_men true_detective).all?{|obj| obj.length >= 7}
      expect(array).to eq(true)
    end
  end

end