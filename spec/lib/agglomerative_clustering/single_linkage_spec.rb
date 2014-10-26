describe AgglomerativeClustering::SingleLinkage do

  context '#calculate_distance' do
    it 'will return the clusters which are closest to each other' do
      single_linkage = AgglomerativeClustering::SingleLinkage.new
      cluster1 = FactoryGirl.build(:cluster)
      cluster2 = FactoryGirl.build(:cluster)
      expect(single_linkage.calculate_distance(cluster1, cluster2)).to eql(single_linkage.euclidean_distance(cluster1.points[0], cluster2.points[0]))
    end
  end
end
