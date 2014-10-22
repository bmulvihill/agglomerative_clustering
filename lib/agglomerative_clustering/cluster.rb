module AgglomerativeClustering
  class Cluster
    attr_reader :points

    def initialize(point)
      points << point
    end

    def points
      @points ||= []
    end

  end
end
