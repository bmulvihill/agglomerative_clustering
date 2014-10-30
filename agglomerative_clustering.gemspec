# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'agglomerative_clustering/version'

Gem::Specification.new do |spec|
  spec.name          = "agglomerative_clustering"
  spec.version       = AgglomerativeClustering::VERSION
  spec.authors       = ["Bryan Mulvihill"]
  spec.email         = ["bmulvihill@pinsonault.com"]
  spec.summary       = %q{Ruby Agglomerative Clustering Algorithm}
  spec.homepage      = "https://github.com/bmulvihill/agglomerative_clustering"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
end
