describe AgglomerativeClustering::Linkage::Base do

  context '#cluster' do
    it 'will return the index of clusters where min distance is closest' do
      single_linkage = AgglomerativeClustering::Linkage::Single.new
      set = FactoryGirl.build(:set)
      set.push(FactoryGirl.build(:point))
      set.push(FactoryGirl.build(:point))
      expect(single_linkage.cluster(set.clusters, set.distance_matrix)).to eql([0,1])
    end
  end

end
