module AgglomerativeClustering
  class Cluster
    attr_reader :points

    # Initialize the Cluster with a point
    def initialize(point)
      points << point
    end

    # Returns all the points in the cluster
    def points
      @points ||= []
    end

    # Merges the points of two clusters
    def merge(cluster)
      cluster.points.each { |point| points << point }
      self
    end

  end
end
