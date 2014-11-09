#!/usr/bin/env ruby
require 'agglomerative_clustering'

single_set = AgglomerativeClustering::Set.new(AgglomerativeClustering::Linkage::Single.new)
complete_set = AgglomerativeClustering::Set.new(AgglomerativeClustering::Linkage::Complete.new)
a = 1
b = 1
c = 1
radius = 25

for i in 0..99
 x = a + (Random.rand(-radius..radius))
 y = a + (Random.rand(-radius..radius))
 z = a + (Random.rand(-radius..radius))
 p = Point.new(x,y,z)
 single_set.push(p)
 complete_set.push(p)
end

a = 200
b = 200
c = 200
radius = 25

for i in 0..99
 x = a + (Random.rand(-radius..radius))
 y = a + (Random.rand(-radius..radius))
 z = a + (Random.rand(-radius..radius))
 p = Point.new(x,y,z)
 single_set.push(p)
 complete_set.push(p)
end

a = 500
b = 500
c = 500
radius = 25

for i in 0..99
 x = a + (Random.rand(-radius..radius))
 y = a + (Random.rand(-radius..radius))
 z = a + (Random.rand(-radius..radius))
 p = Point.new(x,y,z)
 single_set.push(p)
 complete_set.push(p)
end

percentage = 80
distance = 150

# open('points.csv', 'w') do |f|
#   set.points.each do |point|
#     f << "#{point.x},#{point.y},#{point.z}\n"
#   end
# end
#
# open('outliers.csv', 'w') do |f|
#   set.find_outliers(percentage, distance).each do |point|
#     f << "#{point.x},#{point.y},#{point.z}\n"
#   end
# end
#
# if set.outliers.any?
#   puts 'Outliers Removed from Set:'
#   set.outliers.each do |outlier|
#     puts outlier
#   end
# else
#   puts "There are no outliers where #{percentage}% of the points lie at a distance greater than #{distance}"
# end

 clusters1 = single_set.cluster(2)
 clusters2 = complete_set.cluster(2)

clusters1.each_with_index do |cluster, index|
  open("cluster1#{index}.csv", 'w') do |f|
    cluster.points.sort_by{|p| [p.x, p.y, p.z] }.each do |point|
      f << "#{point.x},#{point.y},#{point.z}\n"
    end
  end
end

clusters2.each_with_index do |cluster, index|
  open("cluster2#{index}.csv", 'w') do |f|
    cluster.points.sort_by{|p| [p.x, p.y, p.z] }.each do |point|
      f << "#{point.x},#{point.y},#{point.z}\n"
    end
  end
end
puts clusters1.map(&:points) & clusters2.map(&:points)
puts 'First Set: '
sc1 = AgglomerativeClustering::SilhouetteCoefficient.new(clusters1[0])
puts sc1.measure(clusters1)

puts 'Second Set: '
sc4 = AgglomerativeClustering::SilhouetteCoefficient.new(clusters2[0])
puts sc4.measure(clusters2)
