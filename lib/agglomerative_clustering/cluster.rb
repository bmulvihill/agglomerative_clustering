module AgglomerativeClustering
  class Cluster
    attr_reader :points

    def self.calculate_min_distance(cluster1, cluster2)
      minimum = 1.0/0
      cluster1.points.each do |point1|
        cluster2.points.each do |point2|
          distance = EuclideanDistance.distance(point1, point2)
          minimum = distance if distance < minimum
        end
      end
      minimum
    end

    def initialize(point)
      points << point
    end

    def points
      @points ||= []
    end

  end
end
