require 'matrix'
module AgglomerativeClustering
  class Set
    include EuclideanDistance
    attr_reader :points, :linkage

    def initialize(linkage)
      @linkage = linkage
      @points = []
    end

    def push point
      points << point
    end

    def clusters
      @clusters ||= points.map{ |point| AgglomerativeClustering::Cluster.new(point) }
    end

    def distance_matrix
      @distance_matrix ||= build_distance_matrix
    end

    def cluster total_clusters
      while clusters.size > total_clusters
        clusters_to_merge = @linkage.cluster(clusters, distance_matrix)
        merge_clusters(clusters_to_merge)
      end
      clusters
    end

    def merge_clusters cluster_index
      new_cluster = clusters[cluster_index[0]].merge(clusters[cluster_index[1]])
      clusters.delete_at(cluster_index[0])
      distance_matrix.remove_edge(cluster_index[0])
      clusters.delete_at(cluster_index[1] - 1)
      distance_matrix.remove_edge(cluster_index[1] - 1)
      clusters << new_cluster
      update_distance_matrix(clusters.size - 1, clusters, distance_matrix)
      new_cluster
    end

    def update_distance_matrix new_cluster, clusters, distance_matrix
      distances = []
      clusters.each do |cluster|
        distances << linkage.calculate_distance(clusters[new_cluster], cluster)
      end
      distance_matrix.add_edge(distances)
      distance_matrix
    end

    def outliers
      set_outliers.uniq
    end

    def find_outliers percentage_of_clusters, distance
      distance_matrix.matrix.each_with_index do |index, row, column|
        count_hash[row] ||= 0
        count_hash[row] += 1 if distance_matrix.matrix[row, column] > distance
        set_outliers << points[row] if count_hash[row]/(distance_matrix.matrix.row_count - 1) > percentage_of_clusters/100
      end
      points.reject! { |point| outliers.include?(point) }
      outliers
    end

    private

    def set_outliers
      @set_outliers ||= []
    end

    def count_hash
      @count_hash ||= {}
    end

    def build_distance_matrix
      m = Matrix.build(points.size, points.size) do |row, column|
        euclidean_distance(points[row], points[column]).round(2)
      end
      DistanceMatrix.new(m)
    end

  end
end
