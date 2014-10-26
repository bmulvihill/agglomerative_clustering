describe AgglomerativeClustering::Linkage::Single do

  context '#calculate_distance' do
    it 'will calculate distance between clusters based on the min distnace between points' do
      single_linkage = AgglomerativeClustering::Linkage::Single.new
      min_point = FactoryGirl.build(:point, x: 2, y: 2, z: 2)
      max_point = FactoryGirl.build(:point, x: 5, y: 5, z: 5)
      cluster1 = AgglomerativeClustering::Cluster.new(min_point)
      cluster2 = AgglomerativeClustering::Cluster.new(FactoryGirl.build(:point, x: 1, y: 1, z: 1))
      cluster3 = AgglomerativeClustering::Cluster.new(FactoryGirl.build(:point, x: 7, y: 7, z: 7))
      cluster4 = AgglomerativeClustering::Cluster.new(max_point)
      cluster1 = cluster1.merge(cluster2)
      cluster3 = cluster3.merge(cluster4)
      min_distance = single_linkage.euclidean_distance(min_point, max_point)
      expect(single_linkage.calculate_distance(cluster1, cluster3)).to eql(min_distance)
    end
  end
  
end
