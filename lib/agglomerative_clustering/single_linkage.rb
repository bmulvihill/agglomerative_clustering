module AgglomerativeClustering
  class SingleLinkage
    include EuclideanDistance

    def cluster(clusters)
      min_dist = 1.0/0
      clusters.each_with_index do |cluster1, index|
        clusters[index + 1..clusters.size].each do |cluster2|
          distance = calculate_distance(cluster1, cluster2)
          if distance < min_dist
            min_dist = distance
            @clusters_to_merge = [cluster1, cluster2]
          end
        end
      end
      clusters_to_merge
    end

    def calculate_distance(cluster1, cluster2)
      min_distance = 1.0/0
      cluster1.points.each do |point1|
        cluster2.points.each do |point2|
          distance = euclidean_distance(point1, point2)
          min_distance = distance if distance < min_distance
        end
      end
      min_distance
    end

    def minimum_distance
      @minimum_distance ||= 1.0/0
    end

    def clusters_to_merge
      @clusters_to_merge ||= []
    end

  end
end
