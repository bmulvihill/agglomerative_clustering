describe AgglomerativeClustering::Set do
  context '#find_outliers' do
    it 'will return a list of outliers' do
      set = AgglomerativeClustering::Set.new
      set.push(FactoryGirl.build(:point, x:2, y:2, z:3))
      set.push(FactoryGirl.build(:point, x:1, y:4, z:1))
      set.push(FactoryGirl.build(:point, x:3, y:2, z:2))
      set.push(FactoryGirl.build(:point, x:5, y:2, z:3))
      outlier1 = FactoryGirl.build(:point, x:100, y:200, z:300)
      outlier2 = FactoryGirl.build(:point, x:-100, y:-200, z:-300)
      set.push(outlier1)
      set.push(outlier2)
      fraction = 0.9
      distance = 10
      expect(set.find_outliers(fraction, distance)).to eql([outlier1,outlier2])
    end
  end
end
