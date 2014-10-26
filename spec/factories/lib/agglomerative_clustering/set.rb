FactoryGirl.define do
  factory :set, class: AgglomerativeClustering::Set do
    initialize_with { new(AgglomerativeClustering::Linkage::Single.new) }
  end
end
