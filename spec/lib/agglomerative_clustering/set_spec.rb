describe AgglomerativeClustering::Set do

  before do
    @set = FactoryGirl.build(:set)
  end

  context '#cluster' do
    it 'will return clusters of points based on requested number of clusters' do
      point1 = FactoryGirl.build(:point, x:2, y:2, z:3)
      point2 = FactoryGirl.build(:point, x:1, y:4, z:1)
      point3 = FactoryGirl.build(:point, x:3, y:2, z:2)
      point4 = FactoryGirl.build(:point, x:5, y:2, z:3)
      @set.push(point1)
      @set.push(point2)
      @set.push(point3)
      @set.push(point4)
      expect(@set.cluster(2).size).to eql(2)
    end
  end

  context '#find_outliers' do
    it 'will return a list of outliers' do
      outlier1 = FactoryGirl.build(:point, x:100, y:200, z:300)
      outlier2 = FactoryGirl.build(:point, x:-100, y:-200, z:-300)
      point1 = FactoryGirl.build(:point, x:2, y:2, z:3)
      point2 = FactoryGirl.build(:point, x:1, y:4, z:1)
      point3 = FactoryGirl.build(:point, x:3, y:2, z:2)
      point4 = FactoryGirl.build(:point, x:5, y:2, z:3)
      @set.push(point1)
      @set.push(outlier1)
      @set.push(point2)
      @set.push(point3)
      @set.push(point4)
      @set.push(outlier2)

      percentage_of_points = 90
      distance = 10
      expect(@set.find_outliers(percentage_of_points, distance)).to eql([outlier1, outlier2])
    end
  end

  context '#outliers' do
    it 'will return the set of points without outliers' do
      outlier1 = FactoryGirl.build(:point, x:100, y:200, z:300)
      outlier2 = FactoryGirl.build(:point, x:-100, y:-200, z:-300)
      point1 = FactoryGirl.build(:point, x:2, y:2, z:3)
      point2 = FactoryGirl.build(:point, x:1, y:4, z:1)
      point3 = FactoryGirl.build(:point, x:3, y:2, z:2)
      point4 = FactoryGirl.build(:point, x:5, y:2, z:3)
      @set.push(point1)
      @set.push(outlier1)
      @set.push(point2)
      @set.push(point3)
      @set.push(point4)
      @set.push(outlier2)
      percentage_of_points = 90
      distance = 10
      @set.find_outliers(percentage_of_points, distance)
      expect(@set.outliers).to eql([outlier1,outlier2])
    end
  end
end
