module AgglomerativeClustering
  module EuclideanDistance
    def euclidean_distance point1, point2
      # This takes the square root of the difference of each attribute(x,y,z) squared and added together
      Math.sqrt(point1.zip(point2).map{|a,b| a-b}.map{|d| d*d}.reduce(:+))
    end
  end
end
