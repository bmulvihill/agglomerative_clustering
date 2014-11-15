#!/usr/bin/env ruby
require 'agglomerative_clustering'
puts 'This program will take a set of points and remove any outliers'

puts "Please enter a P value (Percentage of points to determine outliers)"
percentage = gets.chomp.to_f
puts "Please enter a d value (Distance of points to determine outliers)"
distance = gets.chomp.to_f
