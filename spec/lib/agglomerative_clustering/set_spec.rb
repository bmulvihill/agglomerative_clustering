describe AgglomerativeClustering::Set do

  before do
    @set = FactoryGirl.build(:set)
  end

  context '#get_outliers' do
    it 'will return a list of outliers' do
      outlier1 = FactoryGirl.build(:point, x:100, y:200, z:300)
      outlier2 = FactoryGirl.build(:point, x:-100, y:-200, z:-300)
      @set.push(FactoryGirl.build(:point, x:2, y:2, z:3))
      @set.push(outlier1)
      @set.push(FactoryGirl.build(:point, x:1, y:4, z:1))
      @set.push(FactoryGirl.build(:point, x:3, y:2, z:2))
      @set.push(FactoryGirl.build(:point, x:5, y:2, z:3))
      @set.push(outlier2)

      fraction = 0.9
      distance = 10
      expect(@set.get_outliers(fraction, distance)).to eql([outlier1,outlier2])
    end
  end

  context '#set_prime' do
    it 'will return the set of points without outliers' do
      outlier1 = FactoryGirl.build(:point, x:100, y:200, z:300)
      point1 = FactoryGirl.build(:point, x:2, y:2, z:3)
      point2 = FactoryGirl.build(:point, x:1, y:4, z:1)
      point3 = FactoryGirl.build(:point, x:3, y:2, z:2)
      point4 = FactoryGirl.build(:point, x:5, y:2, z:3)
      @set.push(point1)
      @set.push(outlier1)
      @set.push(point2)
      @set.push(point3)
      @set.push(point4)
      fraction = 0.9
      distance = 10
      @set.get_outliers(fraction, distance)
      expect(@set.set_prime).to eql([point1,point2,point3,point4])
    end
  end
end
