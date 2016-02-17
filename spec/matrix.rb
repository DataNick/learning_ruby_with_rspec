require 'matrix'

Matrix[ [1, 2], [3, 4] ]

block = Matrix.build(3, 3) {|row, col| rand(2) }

diag = Matrix.diagonal(10, 20, 30)

array = Array.new(3){Array.new(3){rand(2)} }
puts array