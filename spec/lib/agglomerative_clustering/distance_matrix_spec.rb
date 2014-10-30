describe AgglomerativeClustering::DistanceMatrix do

  context '#remove_edge' do
    it 'will remove edges from the distance matrix' do
      matrix = AgglomerativeClustering::DistanceMatrix.new(Matrix.empty)
      matrix.add_edge([1,2])
      matrix.add_edge([2,2,3])
      expect(matrix.remove_edge(0)).to eql(Matrix[[2,3]])
    end
  end

  context '#add_edge' do
    it 'will add an edges to the distance matrix' do
      matrix = AgglomerativeClustering::DistanceMatrix.new(Matrix.rows([[1,2,3]]))
      expect(matrix.add_edge([4,5,6,7])).to eql(Matrix[[1,2,3,4],[4,5,6,7]])
    end
  end
end
