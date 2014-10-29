module AgglomerativeClustering
  class DistanceMatrix

    def initialize matrix
      @matrix_array = matrix.to_a
    end

    def matrix
      Matrix.build(matrix_array.size, matrix_array.first.size) do |row, column|
        matrix_array[row][column]
      end
    end

    def print_matrix
      puts matrix.to_a.map(&:inspect)
    end

    def remove_edge index
      matrix_array.delete_at(index)
      matrix_array.each { |row| row.delete_at(index) }
      Matrix.rows(matrix_array)
    end

    def add_edge weights
      matrix_array.each_with_index { |row, index|  row << weights[index] }
      matrix_array << weights
      Matrix.rows(matrix_array)
    end
    
    private

    def matrix_array
      @matrix_array ||= []
    end

  end
end
