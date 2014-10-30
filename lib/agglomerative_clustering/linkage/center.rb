module AgglomerativeClustering
  module Linkage
    class Center < Base

      def calculate_distance(cluster1, cluster2)
        point1, point2 = center_point(cluster1), center_point(cluster2)
        euclidean_distance(point1, point2)
      end

      def center_point cluster
        cluster.points.first.zip(*cluster.points[1..cluster.points.size-1]).map { |a,b| (a + b)/cluster.points.size.to_f }
      end
      
    end
  end
end
