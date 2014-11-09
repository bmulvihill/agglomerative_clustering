module AgglomerativeClustering
  module Linkage
    class Complete < Base

      # Determines the distance of two clusters
      # Uses the max distance of all points
      def calculate_distance(cluster1, cluster2)
        max_point_distance = 0
        cluster1.points.each do |point1|
          cluster2.points.each do |point2|
            distance = euclidean_distance(point1, point2)
            max_point_distance = distance if distance > max_point_distance
          end
        end
        max_point_distance
      end

    end
  end
end
