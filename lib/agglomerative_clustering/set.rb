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

    def cluster total_clusters
      create_clusters.each do |cluster|
        puts cluster.inspect
      end
    end

    def outliers
      set_outliers
    end

    def set_prime
      points - outliers
    end

    def find_outliers percentage_of_points, distance
      distance_matrix.each_with_index do |index, row, column|
        count_hash[row] ||= 0
        count_hash[row] += 1 if distance_matrix[row, column] > distance
        set_outliers << points[row] if count_hash[row]/(distance_matrix.row_count - 1) > percentage_of_points/100
      end
      set_outliers.uniq
    end

    private

    def create_clusters
      @clusters ||= []
      set_prime.each do |set|
        @clusters << AgglomerativeClustering::Cluster.new(set)
      end
      @clusters
    end

    def set_outliers
      @set_outliers ||= []
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
