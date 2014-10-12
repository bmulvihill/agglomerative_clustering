describe AgglomerativeClustering::Set do
  context '#find_outliers' do
    it 'will return a list of outliers' do
      set = AgglomerativeClustering::Set.new
      set.push(FactoryGirl.build(:point))
      set.push(FactoryGirl.build(:point))
      set.push(FactoryGirl.build(:point))
      set.push(FactoryGirl.build(:point))
      set.push(FactoryGirl.build(:point))
      set.find_outliers
    end
  end
end
