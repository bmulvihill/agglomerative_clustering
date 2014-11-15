describe AgglomerativeClustering::Linkage::Single do

  context '#calculate_distance' do
    it 'will calculate distance between clusters based on the min distnace between points' do
      single_linkage = AgglomerativeClustering::Linkage::Single.new
      min_point1 = FactoryGirl.build(:point, x: 2, y: 2, z: 2)
      min_point2 = FactoryGirl.build(:point, x: 5, y: 5, z: 5)
      cluster1 = AgglomerativeClustering::Cluster.new(min_point1)
      cluster2 = AgglomerativeClustering::Cluster.new(FactoryGirl.build(:point, x: 1, y: 1, z: 1))
      cluster3 = AgglomerativeClustering::Cluster.new(FactoryGirl.build(:point, x: 7, y: 7, z: 7))
      cluster4 = AgglomerativeClustering::Cluster.new(min_point2)
      cluster1 = cluster1.merge(cluster2)
      cluster3 = cluster3.merge(cluster4)
      min_distance = single_linkage.euclidean_distance(min_point1, min_point2)
      expect(single_linkage.calculate_distance(cluster1, cluster3)).to eql(min_distance)
    end
  end

end
