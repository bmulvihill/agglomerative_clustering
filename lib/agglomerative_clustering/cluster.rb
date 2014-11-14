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
      @points.sort_by!{|p| [p.x, p.y, p.z] } if @points.any?
      @points
    end

    # Merges the points of two clusters
    def merge(cluster)
      cluster.points.each { |point| points << point }
      self
    end

  end
end
