module AgglomerativeClustering
  module Linkage
    class Center < Base

      def calculate_distance(cluster1, cluster2)
        point1, point2 = center_point(cluster1), center_point(cluster2)
        euclidean_distance(point1, point2)
      end

      def center_point cluster
        return cluster.points.first if cluster.points.size == 1
        cluster.points.first.zip(*cluster.points[1..cluster.points.size-1]).map { |a| a.inject(:+).to_f/a.size.to_f }
      end

    end
  end
end
