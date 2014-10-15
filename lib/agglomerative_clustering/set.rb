require 'matrix'
module AgglomerativeClustering
  class Set
    attr_reader :points

    def initialize
      @points = []
    end

    def push point
      @points << point
    end

    def print_distance_matrix
      puts distance_matrix.to_a.map(&:inspect)
    end

    def cluster total_clusters, fraction, distance
    end

    def get_outliers fraction, distance
      distance_matrix.each_with_index do |index, row, column|
        count_hash[row] ||= 0
        count_hash[row] += 1 if distance_matrix[row, column] > distance
        outliers << points[row] if count_hash[row]/(distance_matrix.row_count - 1) > fraction
      end
      outliers.uniq
    end

    private

    def set_prime
      points - outliers
    end

    def outliers
      @outliers ||= []
    end

    def count_hash
      @count_hash ||= {}
    end

    def distance_matrix
      @distance_matrix ||= Matrix.build(points.size, points.size) do |row, column|
        EuclideanDistance.distance(points[row], points[column]).round(2)
      end
    end

  end
end
