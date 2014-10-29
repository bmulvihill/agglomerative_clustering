module AgglomerativeClustering
  module Linkage
    class Base
      include EuclideanDistance

      def cluster clusters, distance_matrix
        min_cluster_dist = 1.0/0
        distance_matrix.matrix.each_with_index do |index, row, column|
          distance = distance_matrix.matrix[row, column]
          if distance < min_cluster_dist && distance != 0
            min_cluster_dist = distance
            @clusters_to_merge = [row, column]
          end
        end
        clusters_to_merge
      end

    end
  end
end
