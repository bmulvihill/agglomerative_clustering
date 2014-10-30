# AgglomerativeClustering

Hierarchical Agglomerative Clustering Algorithm

Input Set of 3 dimensional points, group into nearest k clusters based on Euclidean Distance.
Currently the Clustering Algorithm supports 4 different types of Linkage
* Single Linkage (Distance between clusters is based on nearest points)
* Complete Linkage (Distance between clusters is based on farthest points)
* Average Linkage (Distance between clusters is based on average distance of points)
* Center Linkage (Distance between clusters is based on center of cluster)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'agglomerative_clustering'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install agglomerative_clustering

## Usage
Please see cluster.rb for a sample until I have a chance to write something up here


## Contributing

1. Fork it ( https://github.com/[my-github-username]/agglomerative_clustering/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
