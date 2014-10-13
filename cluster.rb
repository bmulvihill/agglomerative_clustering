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
open('points.csv', 'w') do |f|
  set.points.each do |point|
    f << "#{point.x},#{point.y},#{point.z}\n"
  end
end
