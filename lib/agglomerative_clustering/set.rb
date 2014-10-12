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

    def find_outliers
      distance_matrix.to_a.map(&:inspect)
    end

    private

    def distance_matrix
      @distance_matrix ||= Matrix.build(points.size, points.size) do |row, column|
        EuclideanDistance.distance(points[row], points[column])
      end
    end

  end
end
