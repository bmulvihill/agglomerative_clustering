module AgglomerativeClustering
  class SilhouetteCoefficient
    include EuclideanDistance
    attr_reader :main_cluster

    def initialize main_cluster
      @main_cluster = main_cluster
    end

    def measure clusters
      silhouettes = []
      average_distances = []
        main_cluster.points.each do |point1|
          a1 = calculate_a1(point1)
          (clusters - [main_cluster]).each do |cluster|
            distances = []
            cluster.points.each do |point2|
              distances << euclidean_distance(point1, point2)
            end
            average_distances << distances.inject(:+)/distances.size
          end
          b1 = average_distances.min
          s1 = (b1 - a1)/[a1,b1].max
          silhouettes << s1
        end
      silhouettes.inject(:+) / silhouettes.size
    end

    def calculate_a1 point
      distances = []
      main_cluster.points.each do |point1|
        distances << euclidean_distance(point, point1)
      end
      distances.inject(:+)/(distances.size - 1)
    end

  end
end
