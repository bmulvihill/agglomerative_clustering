FactoryGirl.define do
  factory :cluster, class: AgglomerativeClustering::Cluster do
    initialize_with { new(FactoryGirl.build(:point)) }
  end
end
