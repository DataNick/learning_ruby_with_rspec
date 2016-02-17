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

    it "creates a 5X5 matrix" do
      matrix = Matrix.build(5){|row,col| row; col}
      expect(matrix).to eq(Matrix[[0,1,2,3,4],[0,1,2,3,4],[0,1,2,3,4],[0,1,2,3,4],[0,1,2,3,4]])
    end
  end

  describe "#diagonal" do
    it "returns a matrix with specific numbers forming a diagonal line" do
      diagonal =  Matrix.diagonal(1,2,3,4)
      expect(diagonal).to eq(Matrix[[1,0,0,0],[0,2,0,0],[0,0,3,0],[0,0,0,4]])
    end
  end

  describe "#column_vector(column)" do
    it "creates single-column matrix where the values of the columns are those given in column parameter" do
      matrix = Matrix.column_vector([3, 2, 7])
      expect(matrix).to eq(Matrix[[3],[2],[7]])
    end
  end

  describe "#columns(columns)" do
    it "creates matrix using columns as an array of column vectors" do
      columns = Matrix.columns([[15, -12], [7, -2]])
      expect(columns).to eq(Matrix[[15, 7], [-12,-2]])
    end
  end

  describe "#empty(row_count=0, column_count=0)" do
    it "creates empty matrix of row_count X column_count" do
      a = Matrix.empty(1, 0)
      b = Matrix.empty(0, 3)
      result = a * b
      expect(result).to eq(Matrix[[0, 0, 0]])
    end
  end









end