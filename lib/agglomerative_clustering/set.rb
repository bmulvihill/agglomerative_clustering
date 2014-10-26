require 'matrix'
module AgglomerativeClustering
  class Set
    include EuclideanDistance
    attr_reader :points

    def initialize
      # use dependency injection for linkage algorithms
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
      minimum_clusters =[]
      while clusters.size > total_clusters
        min_dist = 1.0/0
        clusters.each_with_index do |cluster1, index|
          clusters[index + 1..clusters.size].each do |cluster2|
            distance = calculate_distance(cluster1, cluster2)
            if distance < min_dist && distance != 0
              min_dist = distance
              minimum_clusters = [cluster1, cluster2]
            end
          end
        end
        merge_clusters(minimum_clusters)
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
    def calculate_distance(cluster1, cluster2)
      minimum = 1.0/0
      cluster1.points.each do |point1|
        cluster2.points.each do |point2|
          distance = euclidean_distance(point1, point2)
          minimum = distance if distance < minimum
        end
      end
      minimum
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
