require 'matrix'
require 'spec_helper'

describe Matrix do

  describe "#[]" do
    it "creates a matrix where each argument is a row" do
      matrix = Matrix[ [ 2, 2 ],[ 5, 5 ] ]
      expect(matrix).to eq(Matrix[ [ 2, 2 ],[ 5, 5 ] ])
    end
  end

  describe "#build(row_count, column_count = row_count)" do
    it "creates a matrix of size row_count X column_count" do
      matrix = Matrix.build(3,4){|row, col| col-row}
      expect(matrix).to eq(Matrix[[0, 1, 2, 3],[-1, 0, 1, 2],[-2, -1, 0, 1]])
    end
  end

  describe "#diagonal" do
    it "returns a matrix with specific numbers forming a diagonal line" do
      diagonal =  Matrix.diagonal(1,2,3,4)
      expect(diagonal).to eq(Matrix[[1,0,0,0],[0,2,0,0],[0,0,3,0],[0,0,0,4]])
    end
  end

end