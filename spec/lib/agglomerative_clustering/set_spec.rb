describe AgglomerativeClustering::Set do

  before do
    @set = FactoryGirl.build(:set)
  end

  context '#cluster' do
    it 'will return clusters of points based on requested number of clusters' do
      point1 = FactoryGirl.build(:point, x:2, y:2, z:3)
      point2 = FactoryGirl.build(:point, x:1, y:4, z:1)
      point3 = FactoryGirl.build(:point, x:5, y:2, z:2)
      point4 = FactoryGirl.build(:point, x:5, y:2, z:3)
      @set.push(point1)
      @set.push(point2)
      @set.push(point3)
      @set.push(point4)
      expect(@set.cluster(3).size).to eql(3)
    end
  end

  context '#merge_clusters' do
    it 'will merge two clusters into one and update the distance matrix' do
      point1 = FactoryGirl.build(:point, x:2, y:2, z:3)
      point2 = FactoryGirl.build(:point, x:1, y:4, z:1)
      point3 = FactoryGirl.build(:point, x:3, y:2, z:2)
      point4 = FactoryGirl.build(:point, x:5, y:2, z:3)
      @set.push(point1)
      @set.push(point2)
      @set.push(point3)
      @set.push(point4)
      expect(@set.merge_clusters([@set.clusters[0],@set.clusters[1]]).points).to eql([point1, point2])
    end
  end

  context '#calculate_min_distance' do
    it 'will return the minimum distance between two clusters' do
      point1 = FactoryGirl.build(:point, x:2, y:2, z:3)
      point2 = FactoryGirl.build(:point, x:1, y:4, z:1)
      point3 = FactoryGirl.build(:point, x:3, y:2, z:2)
      point4 = FactoryGirl.build(:point, x:5, y:2, z:3)
      @set.push(point1)
      @set.push(point2)
      @set.push(point3)
      @set.push(point4)
      expect(@set.calculate_distance(1,2)).to eql(AgglomerativeClustering::EuclideanDistance.distance(point1,point2))
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
