module AgglomerativeClustering
  module Linkage
    class Average < Base

      # Determines the distance of two clusters
      # Uses the average distance of all points
      def calculate_distance(cluster1, cluster2)
        distances = []
        cluster1.points.each do |point1|
          cluster2.points.each do |point2|
            distances << euclidean_distance(point1, point2)
          end
        end
        distances.inject(:+)/distances.size
      end

    end
  end
end
