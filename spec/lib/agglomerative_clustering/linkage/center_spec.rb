describe AgglomerativeClustering::Linkage::Center do

  context '#calculate_distance' do
    it 'will calculate distance between clusters based on the center distance between points' do
      center_linkage = AgglomerativeClustering::Linkage::Center.new
      point1 = FactoryGirl.build(:point, x: 1, y: 1, z: 1)
      point2 = FactoryGirl.build(:point, x: 2, y: 2, z: 2)
      point3 = FactoryGirl.build(:point, x: 7, y: 7, z: 7)
      point4 = FactoryGirl.build(:point, x: 5, y: 5, z: 5)
      cluster1 = AgglomerativeClustering::Cluster.new(point1)
      cluster2 = AgglomerativeClustering::Cluster.new(point2)
      cluster3 = AgglomerativeClustering::Cluster.new(point3)
      cluster4 = AgglomerativeClustering::Cluster.new(point4)
      cluster1 = cluster1.merge(cluster2)
      cluster3 = cluster3.merge(cluster4)
      center_point1 = Point.new(1.5, 1.5, 1.5)
      center_point2 = Point.new(6, 6, 6)
      center_distance = center_linkage.euclidean_distance(center_point1, center_point2)
      expect(center_linkage.calculate_distance(cluster1, cluster3)).to eql(center_distance)
    end
  end

  context '#center_point' do
    it 'will return the center point of a cluster' do
      center_linkage = AgglomerativeClustering::Linkage::Center.new
      point1 = FactoryGirl.build(:point, x: 1, y: 1, z: 1)
      point2 = FactoryGirl.build(:point, x: 2, y: 2, z: 2)
      point3 = FactoryGirl.build(:point, x: 4, y: 4, z: 4)
      point4 = FactoryGirl.build(:point, x: 5, y: 5, z: 5)
      cluster1 = AgglomerativeClustering::Cluster.new(point1)
      cluster2 = AgglomerativeClustering::Cluster.new(point2)
      cluster3 = AgglomerativeClustering::Cluster.new(point3)
      cluster4 = AgglomerativeClustering::Cluster.new(point4)
      cluster1.merge(cluster2)
      cluster1.merge(cluster3)
      cluster1.merge(cluster4)
      expect(center_linkage.center_point(cluster1)).to eql([3.0,3.0,3.0])
    end
  end

end
