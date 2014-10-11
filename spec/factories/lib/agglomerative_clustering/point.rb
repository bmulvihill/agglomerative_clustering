FactoryGirl.define do
  factory :point, class: Point do
    x { Random.rand(1000) }
    y { Random.rand(1000) }
    z { Random.rand(1000) }
  end
end
