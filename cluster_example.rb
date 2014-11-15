#!/usr/bin/env ruby
require 'agglomerative_clustering'

puts "Enter a total number of points"
points = gets.chomp.to_i
puts "Please enter a P value (Percentage of points to determine outliers)"
percentage = gets.chomp.to_f
puts "Please enter a d value (Distance of points to determine outliers)"
distance = gets.chomp.to_f
puts "Please enter a number of clusters"
k = gets.chomp.to_i
puts "Enter y to enter a center point for each pseudo cluster (Or press enter for random)"
center_points = []
cp_input = gets.chomp
if cp_input == 'y'
  for l in 0..k-1
    center_points << gets.chomp.split(',').map(&:to_i)
  end
else
  for i in 0..k-1
    center_points << [Random.rand(-100..100), Random.rand(-100..100), Random.rand(-100..100)]
  end
end

puts "Processing.."
min_set = AgglomerativeClustering::Set.new(AgglomerativeClustering::Linkage::Single.new)
max_set = AgglomerativeClustering::Set.new(AgglomerativeClustering::Linkage::Complete.new)
average_set = AgglomerativeClustering::Set.new(AgglomerativeClustering::Linkage::Average.new)
center_set = AgglomerativeClustering::Set.new(AgglomerativeClustering::Linkage::Center.new)
sets = [min_set, max_set, average_set, center_set]

# Create set of 500 points based on provided parameters
radius = 25
for clusters in 0..k-1
  cp = center_points[clusters]
  for i in 0..(points/k-1)
    x = cp[0] + (Random.rand(-radius..radius))
    y = cp[1] + (Random.rand(-radius..radius))
    z = cp[2] + (Random.rand(-radius..radius))
    p = Point.new(x,y,z)
    sets.each {|set| set.push(p)}
  end
end

# add an outlier in case none are generated
#outlier = Point.new(500,500,50)
#sets.each {|set| set.push(outlier)}


# Find and Remove Outliers in the Set
sets.each do |set|
  set.find_outliers(percentage, distance)
end

# Output outliers to the console
if min_set.outliers.any?
  puts 'Outliers Removed from Set:'
  min_set.outliers.each do |outlier|
    puts outlier
  end
else
  puts "There are no outliers where #{percentage}% of the points lie at a distance greater than #{distance}"
end

# Run the clustering algorithms
min_clusters = min_set.cluster(k)
max_clusters = max_set.cluster(k)
average_clusters = average_set.cluster(k)
center_clusters = center_set.cluster(k)

# Outputs points on each cluster
puts "=====Minimum Linkage Clusters====="
min_clusters.each{|c| p c.points}
puts "=====Maximum Linkage Clusters====="
max_clusters.each{|c| p c.points}
puts "=====Average Linkage Clusters====="
average_clusters.each{|c| p c.points}
puts "=====Center Linkage Clusters======"
center_clusters.each{|c| p c.points}

# Output Silhouette Coefficients for the clusters in each set
puts 'Minimum Linkage Silhouette Coefficients: '
s1 = min_clusters.map { |c| AgglomerativeClustering::SilhouetteCoefficient.new(c).measure(min_clusters) }
p s1
puts 'Maximum Linkage Silhouette Coefficients: '
s2 = max_clusters.map { |c| AgglomerativeClustering::SilhouetteCoefficient.new(c).measure(max_clusters) }
p s2
puts 'Average Linkage Silhouette Coefficients: '
s3 = average_clusters.map { |cluster| AgglomerativeClustering::SilhouetteCoefficient.new(cluster).measure(average_clusters) }
p s3
puts 'Center Linkage Silhouette Coefficients: '
s4 = center_clusters.map { |cluster| AgglomerativeClustering::SilhouetteCoefficient.new(cluster).measure(center_clusters) }
p s4

# output best average silhouette coefficient
type_hash = {0 => 'Minimum', 1 => 'Maximum', 2 => 'Average', 3 => 'Center'}
all = [s1,s2,s3,s4].map { |s| s.inject(:+)/s.size }
puts "The best Average Silhouette Coefficient is #{all.max} from #{type_hash[all.index(all.max)]} Linkage"
