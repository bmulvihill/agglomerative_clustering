module AgglomerativeClustering
  module EuclideanDistance
    def euclidean_distance point1, point2
      # Thanks to https://blog.philipcunningham.org/posts/ruby-euclidean-distance
      Math.sqrt(point1.zip(point2).map{|a,b| a-b}.map{|d| d*d}.reduce(:+))
    end
  end
end
