describe AgglomerativeClustering::Set do

  before do
    @set = FactoryGirl.build(:set)
    @point1 = FactoryGirl.build(:point, x:1, y:2, z:3)
    @point2 = FactoryGirl.build(:point, x:2, y:4, z:1)
    @point3 = FactoryGirl.build(:point, x:4, y:2, z:2)
    @point4 = FactoryGirl.build(:point, x:5, y:2, z:3)
    @set.push(@point1)
    @set.push(@point2)
    @set.push(@point3)
    @set.push(@point4)
  end

  context '#cluster' do
    it 'will return clusters of points based on requested number of clusters' do
      expect(@set.cluster(2).size).to eql(2)
    end

    it 'will cluster points that are closest to each other' do
      @point5 = FactoryGirl.build(:point, x:6, y:2, z:4)
      @point6 = FactoryGirl.build(:point, x:7, y:3, z:4)
      @point7 = FactoryGirl.build(:point, x:15, y:20, z:21)
      @point8 = FactoryGirl.build(:point, x:16, y:21, z:21)
      @point9 = FactoryGirl.build(:point, x:18, y:22, z:21)
      @set.push(@point5)
      @set.push(@point6)
      @set.push(@point7)
      @set.push(@point8)
      @set.push(@point9)
      clusters = @set.cluster(3)
      points = clusters.map(&:points).each {|cluster| cluster.sort_by!(&:x) }
      expect([[@point1, @point2],[@point3, @point4, @point5, @point6], [@point7, @point8, @point9]] - points).to eql([])

    end
  end

  context '#find_outliers' do
    it 'will return a list of outliers' do
      outlier1 = FactoryGirl.build(:point, x:100, y:200, z:300)
      outlier2 = FactoryGirl.build(:point, x:-100, y:-200, z:-300)
      @set.push(outlier1)
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
      @set.push(outlier1)
      @set.push(outlier2)
      percentage_of_points = 90
      distance = 10
      @set.find_outliers(percentage_of_points, distance)
      expect(@set.outliers).to eql([outlier1,outlier2])
    end
  end
end
