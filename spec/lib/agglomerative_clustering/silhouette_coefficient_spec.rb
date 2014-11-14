describe AgglomerativeClustering::SilhouetteCoefficient do

  context '#measure' do
    it 'will return the average silhoutte coefficient of a cluster' do
      p1 = FactoryGirl.build(:point, x:1, y:1, z:1)
      p2 = FactoryGirl.build(:point, x:3, y:3, z:3)
      p3 = FactoryGirl.build(:point, x:17, y:17, z:17)
      p4 = FactoryGirl.build(:point, x:16, y:16, z:16)
      p5 = FactoryGirl.build(:point, x:18, y:18, z:18)
      p6 = FactoryGirl.build(:point, x:2, y:2, z:2)
      cluster1 = AgglomerativeClustering::Cluster.new(p1)
      cluster2 = AgglomerativeClustering::Cluster.new(p2)
      cluster3 = AgglomerativeClustering::Cluster.new(p3)
      cluster4 = AgglomerativeClustering::Cluster.new(p4)
      cluster5 = AgglomerativeClustering::Cluster.new(p5)
      cluster6 = AgglomerativeClustering::Cluster.new(p6)
      cluster1.merge(cluster2).merge(cluster3)
      cluster4.merge(cluster5).merge(cluster6)
      sc = AgglomerativeClustering::SilhouetteCoefficient.new(cluster1)
      clusters = [cluster1, cluster4]
      expect(sc.measure(clusters)).to eql(-0.09)
    end
  end
end
