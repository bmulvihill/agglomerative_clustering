module AgglomerativeClustering
  module Linkage
    class Complete
      attr_reader :distance_matrix

      def cluster(clusters, distance_matrix)
        @distance_matrix ||= distance_matrix
        min_cluster_dist = 1.0/0
        clusters.each_with_index do |cluster1, index|
          clusters[index + 1..clusters.size].each do |cluster2|
            distance = calculate_distance(cluster1, cluster2)
            if distance < min_cluster_dist
              min_cluster_dist = distance
              @clusters_to_merge = [cluster1, cluster2]
            end
          end
        end
        clusters_to_merge
      end

      def calculate_distance(cluster1, cluster2)
        max_point_distance = 0
        cluster1.points.each do |point1|
          cluster2.points.each do |point2|
            distance = @distance_matrix[point1.index, point2.index]
            max_point_distance = distance if distance > max_point_distance
          end
        end
        max_point_distance
      end

      def clusters_to_merge
        @clusters_to_merge ||= []
      end

    end
  end
end
