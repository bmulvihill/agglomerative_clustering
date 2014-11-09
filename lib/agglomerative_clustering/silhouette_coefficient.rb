module AgglomerativeClustering
  class SilhouetteCoefficient
    include EuclideanDistance
    attr_reader :main_cluster

    def initialize main_cluster
      @main_cluster = main_cluster
    end

    # Measures the silhouette coefficient of a cluster compared to all other clusters
    # Returns the average silhouette coefficient of a cluster
    def measure clusters
      silhouettes = []
      average_distances = []
        main_cluster.points.each do |point1|
          a1 = calculate_a1(point1)
          (clusters - [main_cluster]).each do |cluster|
            distances = []
            cluster.points.each do |point2|
              distances << euclidean_distance(point1, point2).round(2)
            end
            average_distances << distances.inject(:+)/distances.size
          end
          b1 = average_distances.min
          s1 = (b1 - a1)/[a1,b1].max
          silhouettes << s1
        end
      (silhouettes.inject(:+) / silhouettes.size).round(2)
    end

    # Calculates the a1 value of a cluster
    def calculate_a1 point
      distances = []
      main_cluster.points.each do |point1|
        distances << euclidean_distance(point, point1).round(2)
      end
      (distances.inject(:+)/(distances.size - 1)).round(2)
    end

  end
end
