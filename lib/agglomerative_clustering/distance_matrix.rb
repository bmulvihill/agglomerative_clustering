require 'matrix'
module AgglomerativeClustering
  class DistanceMatrix

    def initialize matrix
      @matrix_array = matrix.to_a
    end

    def matrix
      @matrix ||= build_matrix
    end

    def print_matrix
      puts matrix.to_a.map(&:inspect)
    end

    def remove_edge index
      matrix_array.delete_at(index)
      matrix_array.each { |row| row.delete_at(index) }
    end

    def add_edge weights
      matrix_array.each_with_index { |row, index|  row << weights[index] }
      matrix_array << weights
      @matrix = build_matrix
    end

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

    def matrix_array
      @matrix_array ||= []
    end

    def build_matrix
      Matrix.build(matrix_array.size, matrix_array.first.size) do |row, column|
        matrix_array[row][column]
      end
    end

  end
end
