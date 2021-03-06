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

  describe "#diagonal" do # matrix having non-zero elements only in the diagonal running from the upper left to lower right
    it "returns a matrix with specific numbers forming a diagonal line" do
      diagonal =  Matrix.diagonal(1,2,3,4)
      expect(diagonal).to eq(Matrix[[1,0,0,0],[0,2,0,0],[0,0,3,0],[0,0,0,4]])
    end
  end

  describe "#column_vector(column)" do
    it "creates single-column matrix where the values of the columns are those given in column parameter" do
      columns = Matrix.column_vector([3, 2, 7])
      expect(columns).to eq(Matrix[[3],[2],[7]])
    end
  end

  describe "#row_vector(row)" do
    it "creates single-row matrix where values of row are given as parameter row" do
      rows = Matrix.row_vector([9, 8, 2])
      expect(rows).to eq(Matrix[[9, 8, 2]])
    end
  end

  describe "#columns(columns)" do
    it "creates matrix using columns as an array of column vectors" do
      columns = Matrix.columns([[15, -12], [7, -2]])
      expect(columns).to eq(Matrix[[15, 7], [-12,-2]])
    end
  end

  describe "#rows(rows)" do
    it "creates a matrix where rows array of arrays, each of which is a row in the matrix" do
      rows = Matrix.rows([[1,2,3], [6,7,8]])
      expect(rows).to eq(Matrix[[1 ,2, 3], [6, 7, 8]])
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

  describe "#identity(n)" do # square matrix where all elements of principal diagonal are 1 and other elements are 0; Effect of multiplying a given matrix by identity matrix is to leave identity matrix unchanged
    it "creates an n X n identity matrix" do
      matrix = Matrix.identity(3)
      expect(matrix).to eq(Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]])
    end
  end

  describe "#unit(n)" do #same as identity matrix
    it "creates an n X n unit matrix" do
      matrix = Matrix.unit(3)
      expect(matrix).to eq(Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]])
    end
  end

  describe "#scalar(n, value)" do
    it "creates and n X n diagonal matrix where each diagonal element is value" do
      scalar = Matrix.scalar(3, 2)
      expect(scalar).to eq(Matrix[[2, 0, 0], [0, 2, 0], [0, 0, 2]])
    end
  end

  describe "#zero(row_count, column_count = row_count)" do
    it "creates a zero matrix" do
      zeroed = Matrix.zero(4,5)
      expect(zeroed).to eq(Matrix[[ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0 ]])
    end
  end

end