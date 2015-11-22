require 'spec_helper'

describe Object do

  describe "#nil?" do
    it "returns true if object == nil" do
      result = nil.nil?
      expect(result).to eq(true)
    end
  end


end