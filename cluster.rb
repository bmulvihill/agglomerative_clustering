#!/usr/bin/env ruby
require 'agglomerative_clustering'

single_set = AgglomerativeClustering::Set.new(AgglomerativeClustering::Linkage::Single.new)
complete_set = AgglomerativeClustering::Set.new(AgglomerativeClustering::Linkage::Complete.new)
average_set = AgglomerativeClustering::Set.new(AgglomerativeClustering::Linkage::Average.new)
center_set = AgglomerativeClustering::Set.new(AgglomerativeClustering::Linkage::Center.new)

a = 1
b = 1
c = 1
radius = 25

for i in 0..10
 x = a + (Random.rand(-radius..radius))
 y = a + (Random.rand(-radius..radius))
 z = a + (Random.rand(-radius..radius))
 p = Point.new(x,y,z)
 single_set.push(p)
 complete_set.push(p)
 average_set.push(p)
 center_set.push(p)
end

a = 150
b = 150
c = 150
radius = 25

for i in 0..10
 x = a + (Random.rand(-radius..radius))
 y = a + (Random.rand(-radius..radius))
 z = a + (Random.rand(-radius..radius))
 p = Point.new(x,y,z)
single_set.push(p)
complete_set.push(p)
average_set.push(p)
center_set.push(p)
end

a = 300
b = 300
c = 300
radius = 25

for i in 0..10
 x = a + (Random.rand(-radius..radius))
 y = a + (Random.rand(-radius..radius))
 z = a + (Random.rand(-radius..radius))
 p = Point.new(x,y,z)
single_set.push(p)
complete_set.push(p)
average_set.push(p)
center_set.push(p)
end

percentage = 80
distance = 150

open('points.csv', 'w') do |f|
  single_set.points.each do |point|
    f << "#{point.x},#{point.y},#{point.z}\n"
  end
end

open('outliers.csv', 'w') do |f|
  single_set.find_outliers(percentage, distance).each do |point|
    f << "#{point.x},#{point.y},#{point.z}\n"
  end
end

if single_set.outliers.any?
  puts 'Outliers Removed from Set:'
  set.outliers.each do |outlier|
    puts outlier
  end
else
  puts "There are no outliers where #{percentage}% of the points lie at a distance greater than #{distance}"
end

 #clusters1 = single_set.cluster(3)
 #clusters2 = complete_set.cluster(3)
 #clusters3 = average_set.cluster(3)
 clusters4 = center_set.cluster(3)


# clusters1.each_with_index do |cluster, index|
#   open("cluster1#{index}.csv", 'w') do |f|
#     cluster.points.each do |point|
#       f << "#{point.x},#{point.y},#{point.z}\n"
#     end
#   end
# end
#
# clusters2.each_with_index do |cluster, index|
#   open("cluster2#{index}.csv", 'w') do |f|
#     cluster.points.each do |point|
#       f << "#{point.x},#{point.y},#{point.z}\n"
#     end
#   end
# end
#
# clusters3.each_with_index do |cluster, index|
#   open("cluster3#{index}.csv", 'w') do |f|
#     cluster.points.sort_by{|p| [p.x, p.y, p.z] }.each do |point|
#       f << "#{point.x},#{point.y},#{point.z}\n"
#     end
#   end
# end

clusters4.each_with_index do |cluster, index|
  open("cluster4#{index}.csv", 'w') do |f|
    cluster.points.sort_by{|p| [p.x, p.y, p.z] }.each do |point|
      f << "#{point.x},#{point.y},#{point.z}\n"
    end
  end
end
#
# puts 'Single Linkage Silhouette Coefficients: '
# clusters1.map { |c| puts AgglomerativeClustering::SilhouetteCoefficient.new(c).measure(clusters1) }
#
# puts 'Complete Linkage Silhouette Coefficients: '
# clusters2.map { |c| puts AgglomerativeClustering::SilhouetteCoefficient.new(c).measure(clusters2) }
#
# puts 'Average Linkage Silhouette Coefficients: '
# clusters3.map { |cluster| puts AgglomerativeClustering::SilhouetteCoefficient.new(cluster).measure(clusters3) }

puts 'Center Linkage Silhouette Coefficients: '
clusters4.map { |cluster| puts AgglomerativeClustering::SilhouetteCoefficient.new(cluster).measure(clusters4) }
