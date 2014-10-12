module AgglomerativeClustering
  class EuclideanDistance
    def self.distance point1, point2
      # Thanks to https://blog.philipcunningham.org/posts/ruby-euclidean-distance
      Math.sqrt(point1.zip(point2).map{|a,b| a-b}.map{|d| d*d}.reduce(:+))
    end
  end
end
