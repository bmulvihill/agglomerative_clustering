describe AgglomerativeClustering::Linkage::Complete do

  context '#cluster' do
    it 'will return the clusters which are closest to each other' do
      single_linkage = AgglomerativeClustering::Linkage::Complete.new
      set = FactoryGirl.build(:set)
      set.push(FactoryGirl.build(:point, x: 1, y: 2, z: 3))
      set.push(FactoryGirl.build(:point, x: 2, y: 2, z: 4))
      set.push(FactoryGirl.build(:point, x: 3, y: 2, z: 4))
      set.push(FactoryGirl.build(:point, x: 4, y: 2, z: 4))
      expect(single_linkage.cluster(set.clusters, set.distance_matrix)).to eql([set.clusters[1], set.clusters[2]])
    end
  end
end
