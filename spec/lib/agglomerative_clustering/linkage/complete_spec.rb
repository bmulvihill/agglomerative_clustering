describe AgglomerativeClustering::Linkage::Complete do

  context '#calculate_distance' do
    it 'will calculate distance between clusters based on the max distnace between points' do
      complete_linkage = AgglomerativeClustering::Linkage::Complete.new
      min_point = FactoryGirl.build(:point, x: 1, y: 1, z: 1)
      max_point = FactoryGirl.build(:point, x: 7, y: 7, z: 7)
      cluster1 = AgglomerativeClustering::Cluster.new(min_point)
      cluster2 = AgglomerativeClustering::Cluster.new(FactoryGirl.build(:point, x: 2, y: 2, z: 2))
      cluster3 = AgglomerativeClustering::Cluster.new(FactoryGirl.build(:point, x: 5, y: 5, z: 5))
      cluster4 = AgglomerativeClustering::Cluster.new(max_point)
      cluster1 = cluster1.merge(cluster2)
      cluster3 = cluster3.merge(cluster4)
      max_distance = complete_linkage.euclidean_distance(min_point, max_point)
      expect(complete_linkage.calculate_distance(cluster1, cluster3)).to eql(max_distance)
    end
  end
  
end
