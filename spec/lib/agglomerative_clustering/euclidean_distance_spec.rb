describe AgglomerativeClustering::EuclideanDistance do
  before do
    class Dummy
      include AgglomerativeClustering::EuclideanDistance
    end
  end

  context '#distance' do
    it 'will return the distance between two points' do
      p1 = FactoryGirl.build(:point, x: -1, y: 2, z: 3)
      p2 = FactoryGirl.build(:point, x: 4 ,y: 0, z: -3)
      expect(Dummy.new.euclidean_distance(p1,p2).round(3)).to eql(8.062)
    end
  end
end
