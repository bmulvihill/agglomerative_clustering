FactoryGirl.define do
  factory :set, class: AgglomerativeClustering::Set do
    initialize_with { new(AgglomerativeClustering::SingleLinkage.new) }
  end
end
