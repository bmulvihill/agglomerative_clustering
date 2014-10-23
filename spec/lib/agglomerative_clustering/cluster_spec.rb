describe AgglomerativeClustering::Cluster do

  context '#calculate_min_distance' do
    it 'will return the minimum distance between two clusters' do
      cluster1 = FactoryGirl.build(:cluster)
      cluster2 = FactoryGirl.build(:cluster)
      expect(AgglomerativeClustering::Cluster.calculate_min_distance(cluster1, cluster2)).to eql(AgglomerativeClustering::EuclideanDistance.distance(cluster1.points[0], cluster2.points[0]))
    end
  end
end
