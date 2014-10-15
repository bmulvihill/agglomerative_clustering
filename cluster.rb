#!/usr/bin/env ruby
require 'agglomerative_clustering'

set = AgglomerativeClustering::Set.new
for i in 0..499
  x = Random.rand(1000)
  y = Random.rand(1000)
  z = Random.rand(1000)
  p = Point.new(x,y,z)
  set.push(p)
end

fraction = 9.0/10.0
distance = 150

open('points.csv', 'w') do |f|
  set.points.each do |point|
    f << "#{point.x},#{point.y},#{point.z}\n"
  end
end

open('outliers.csv', 'w') do |f|
  set.find_outliers(fraction, distance).each do |point|
    f << "#{point.x},#{point.y},#{point.z}\n"
  end
end

if set.outliers.any?
  set.outliers.each do |outlier|
    puts outlier
  end
else
  puts "There are no outliers where #{fraction} of the points lie at a distance greater than #{distance}"
end
