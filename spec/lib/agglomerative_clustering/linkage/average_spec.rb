describe AgglomerativeClustering::Linkage::Average do

  context '#calculate_distance' do
    it 'will calculate distance between clusters based on the average distnace between points' do
      average_linkage = AgglomerativeClustering::Linkage::Average.new
      point1 = FactoryGirl.build(:point, x: 1, y: 1, z: 1)
      point2 = FactoryGirl.build(:point, x: 7, y: 7, z: 7)
      point3 = FactoryGirl.build(:point, x: 2, y: 2, z: 2)
      point4 = FactoryGirl.build(:point, x: 5, y: 5, z: 5)
      cluster1 = AgglomerativeClustering::Cluster.new(point1)
      cluster2 = AgglomerativeClustering::Cluster.new(point2)
      cluster3 = AgglomerativeClustering::Cluster.new(point3)
      cluster4 = AgglomerativeClustering::Cluster.new(point4)
      cluster1 = cluster1.merge(cluster2)
      cluster3 = cluster3.merge(cluster4)
      distance1 = average_linkage.euclidean_distance(point1, point3)
      distance2 = average_linkage.euclidean_distance(point1, point4)
      distance3 = average_linkage.euclidean_distance(point2, point3)
      distance4 = average_linkage.euclidean_distance(point2, point4)
      average_distance = (distance1 + distance2 + distance3 + distance4)/4
      expect(average_linkage.calculate_distance(cluster1, cluster3)).to eql(average_distance)
    end
  end
  
end
