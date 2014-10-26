describe AgglomerativeClustering::Linkage::Base do

  context '#cluster' do
    it 'will return the clusters where min distance is closest' do
      single_linkage = AgglomerativeClustering::Linkage::Single.new
      set = FactoryGirl.build(:set)
      set.push(FactoryGirl.build(:point))
      set.push(FactoryGirl.build(:point))
      expect(single_linkage.cluster(set.clusters)).to eql([set.clusters[0], set.clusters[1]])
    end
  end

end
