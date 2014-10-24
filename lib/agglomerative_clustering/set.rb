require 'matrix'
module AgglomerativeClustering
  class Set
    attr_reader :clusters

    def initialize
      # use dependency injection for linkage algorithms
      @clusters = []
    end

    def push point
      @clusters << AgglomerativeClustering::Cluster.new(point)
    end

    def print_distance_matrix
      puts distance_matrix.to_a.map(&:inspect)
    end

    # merge all clusters
    def cluster total_clusters
      min_clusters =[]
      current_clusters = 0
      while current_clusters < total_clusters
        min_dist = 1.0/0
        distance_matrix.each_with_index do |index, row, column|
          distance = calculate_distance(row, column)
          if distance < min_dist && distance != 0
            min_dist = distance
            min_clusters = [clusters[row], clusters[column]]
          end
        end
        merge_clusters(min_clusters)
        current_clusters += 1
      end
      clusters
    end

    # merge clusters and remove cluster from cluster array
    def merge_clusters(min_clusters)
      min_clusters[0].merge(min_clusters[1])
      clusters.reject! { |cluster| cluster == min_clusters[1] }
      min_clusters[0]
    end

    # make this part of linkage algorithm (calculate_distance interface)
    # returns minimum distance between two clusters
    def calculate_distance(row, column)
      minimum = 1.0/0
      clusters[row].points.each do |point1|
        clusters[column].points.each do |point2|
          distance = EuclideanDistance.distance(point1, point2)
          minimum = distance if distance < minimum
        end unless clusters[column].nil?
      end unless clusters[row].nil?
      minimum
    end

    def outliers
      set_outliers.flat_map(&:points).uniq
    end

    def find_outliers percentage_of_clusters, distance
      distance_matrix.each_with_index do |index, row, column|
        count_hash[row] ||= 0
        count_hash[row] += 1 if distance_matrix[row, column] > distance
        set_outliers << clusters[row] if count_hash[row]/(distance_matrix.row_count - 1) > percentage_of_clusters/100
      end
      clusters.reject! { |cluster| outliers.include?(cluster) }
      @distance_matrix = build_distance_matrix
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
      Matrix.build(clusters.size, clusters.size) do |row, column|
        EuclideanDistance.distance(clusters[row].points[0], clusters[column].points[0]).round(2)
      end
    end

  end
end
