module AgglomerativeClustering
  class Cluster
    attr_reader :points

    def initialize(point)
      points << point
    end

    def points
      @points ||= []
    end

    def merge(cluster)
      cluster.points.each { |point| points << point }
      self
    end

  end
end
