module AgglomerativeClustering
  class Cluster
    attr_reader :points

    def initialize(point)
      points << point
    end

    def points
      @points ||= []
      @points.sort_by!{|p| [p.x, p.y, p.z] } if @points.any?
      @points
    end

    def merge(cluster)
      cluster.points.each { |point| points << point }
      self
    end

  end
end
