describe AgglomerativeClustering::Cluster do

  context '#merge' do
    it 'will merge two clusters' do
      cluster1 = FactoryGirl.build(:cluster)
      cluster2 = FactoryGirl.build(:cluster)
      points = cluster1.points + cluster2.points
      expect(cluster1.merge(cluster2).points).to eql(points)
    end
  end
end
