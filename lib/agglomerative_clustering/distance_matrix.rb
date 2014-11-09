require 'matrix'
module AgglomerativeClustering
  class DistanceMatrix

    # Initialize this class with a matrix of distances
    def initialize matrix
      @matrix_array = matrix.to_a
    end

    # Returns the distance matrix
    def matrix
      @matrix ||= build_matrix
    end

    # Prints the distance matrix
    def print_matrix
      puts matrix.to_a.map(&:inspect)
    end

    # Removes an edges from the distance matrix
    # Removes the row and column
    def remove_edge index
      matrix_array.delete_at(index)
      matrix_array.each { |row| row.delete_at(index) }
    end

    # Adds a new edge to the distance matrix
    # Adds a new row and column
    def add_edge weights
      matrix_array.each_with_index { |row, index|  row << weights[index] }
      matrix_array << weights
      @matrix = build_matrix
    end

    # Returns the current shortest distance in the matrix
    def shortest_distance
      min_dist = 1.0/0
      indexes = []
      matrix.each_with_index do |index, row, column|
        distance = matrix[row, column]
        if distance < min_dist && (row != column)
          min_dist = distance
          indexes = [row, column]
        end
      end
      indexes
    end

    private

    # Internal array that stores all the matrix values
    def matrix_array
      @matrix_array ||= []
    end

    # turns the internal Array into a Matrix
    def build_matrix
      Matrix.build(matrix_array.size, matrix_array.first.size) do |row, column|
        matrix_array[row][column]
      end
    end

  end
end
