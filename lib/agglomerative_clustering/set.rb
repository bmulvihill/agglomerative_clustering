module AgglomerativeClustering
  class Set
    include EuclideanDistance
    attr_reader :linkage

    def initialize(linkage)
      @linkage = linkage
    end

    def points
      @points ||= []
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
        merge_clusters(distance_matrix.shortest_distance)
      end
      clusters
    end

    def outliers
      set_outliers.uniq
    end

    def find_outliers percentage_of_clusters, distance
      distance_matrix.matrix.each_with_index do |index, row, column|
        count_hash[row] ||= 0
        count_hash[row] += 1 if distance_matrix.matrix[row, column] > distance
        if count_hash[row]/(distance_matrix.matrix.row_count - 1) > percentage_of_clusters/100
          set_outliers << points[row]
        end
      end
      points.reject! { |point| outliers.include?(point) }
      @distance_matrix = build_distance_matrix
      outliers
    end

    private

    def merge_clusters indexes
      index1, index2 = indexes
      new_cluster = clusters[index1].merge(clusters[index2])
      remove_cluster(index1)
      remove_cluster(index2 - 1)
      add_cluster(new_cluster)
    end

    def update_distance_matrix new_cluster
      distances = []
      clusters.each do |cluster|
        distances << linkage.calculate_distance(clusters[new_cluster], cluster)
      end
      distance_matrix.add_edge(distances)
      distance_matrix
    end

    def add_cluster new_cluster
      clusters << new_cluster
      update_distance_matrix(clusters.size - 1)
      new_cluster
    end

    def remove_cluster index
      clusters.delete_at(index)
      distance_matrix.remove_edge(index)
    end

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
