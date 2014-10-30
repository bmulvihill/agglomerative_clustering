module AgglomerativeClustering
  module Linkage
    class Single < Base

      def calculate_distance(cluster1, cluster2)
        min_point_distance = 1.0/0
        cluster1.points.each do |point1|
          cluster2.points.each do |point2|
            distance = euclidean_distance(point1, point2)
            min_point_distance = distance if distance < min_point_distance
          end
        end
        min_point_distance
      end

    end
  end
end
