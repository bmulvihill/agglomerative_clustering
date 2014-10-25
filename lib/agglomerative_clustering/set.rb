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

    # merge all clusters
    def cluster total_clusters
      min_clusters =[]
      current_clusters = 0
      while clusters.size > total_clusters
        min_dist = 1.0/0
        distance_matrix.each_with_index do |index, row, column|
          distance = calculate_distance(row, column)
          if distance < min_dist && distance != 0
            min_dist = distance
            min_clusters = [clusters[row], clusters[column]]
          end
        end
        merge_clusters(min_clusters)
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
          distance = distance(point1, point2)
          minimum = distance if distance < minimum
        end unless clusters[column].nil? #cluster has been merged
      end unless clusters[row].nil? #cluster has been merged
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
      remove_outliers
      outliers
    end

    private

    def remove_outliers
      points.reject! { |point| outliers.include?(point) }
    end

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
        distance(points[row], points[column]).round(2)
      end
    end

  end
end
