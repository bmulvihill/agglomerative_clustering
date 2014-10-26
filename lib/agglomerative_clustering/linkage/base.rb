module AgglomerativeClustering
  module Linkage
    class Base
      include EuclideanDistance
      
      def cluster(clusters)
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
    end
  end
end
