require 'matrix'
module AgglomerativeClustering
  class Set
    include EuclideanDistance
    attr_reader :points

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

    def print_distance_matrix
      puts distance_matrix.to_a.map(&:inspect)
    end

    def cluster total_clusters
      clusters_to_merge =[]
      while clusters.size > total_clusters
        clusters_to_merge = @linkage.cluster(clusters)
        merge_clusters(clusters_to_merge)
      end
      clusters
    end

    # merge clusters and remove cluster from cluster array
    def merge_clusters(min_clusters)
      min_clusters[0].merge(min_clusters[1])
      clusters.reject! { |cluster| cluster == min_clusters[1] }
      min_clusters[0]
    end

    def outliers
      set_outliers.uniq
    end

    def find_outliers percentage_of_clusters, distance
      distance_matrix.each_with_index do |index, row, column|
        count_hash[row] ||= 0
        count_hash[row] += 1 if distance_matrix[row, column] > distance
        set_outliers << points[row] if count_hash[row]/(distance_matrix.row_count - 1) > percentage_of_clusters/100
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

    def distance_matrix
      @distance_matrix ||= build_distance_matrix
    end

    def build_distance_matrix
      Matrix.build(points.size, points.size) do |row, column|
        euclidean_distance(points[row], points[column]).round(2)
      end
    end

  end
end
