#!/usr/bin/env ruby
require 'agglomerative_clustering'

set = AgglomerativeClustering::Set.new(AgglomerativeClustering::Linkage::Single.new)
for i in 0..99
  x = Random.rand(0..100)
  y = Random.rand(0..100)
  z = Random.rand(0..100)
  p = Point.new(x,y,z)
  set.push(p)
end
for i in 100..199
  x = Random.rand(200..299)
  y = Random.rand(200..299)
  z = Random.rand(200..299)
  p = Point.new(x,y,z)
  set.push(p)
end
for i in 200..299
  x = Random.rand(400..499)
  y = Random.rand(400..499)
  z = Random.rand(400..499)
  p = Point.new(x,y,z)
  set.push(p)
end

percentage = 80
distance = 150

open('points.csv', 'w') do |f|
  set.points.each do |point|
    f << "#{point.x},#{point.y},#{point.z}\n"
  end
end

open('outliers.csv', 'w') do |f|
  set.find_outliers(percentage, distance).each do |point|
    f << "#{point.x},#{point.y},#{point.z}\n"
  end
end

if set.outliers.any?
  puts 'Outliers Removed from Set:'
  set.outliers.each do |outlier|
    puts outlier
  end
else
  puts "There are no outliers where #{percentage}% of the points lie at a distance greater than #{distance}"
end

clusters = set.cluster(3)
clusters.each_with_index do |cluster, index|
  open("cluster#{index}.csv", 'w') do |f|
    cluster.points.each do |point|
      f << "#{point.x},#{point.y},#{point.z}\n"
    end
  end
end

puts 'Silhouette Coefficient of First Cluster: '
sc = AgglomerativeClustering::SilhouetteCoefficient.new(clusters[0])
puts sc.measure(clusters)
