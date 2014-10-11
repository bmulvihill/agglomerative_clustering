require 'factory_girl'
require 'agglomerative_clustering'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  FactoryGirl.find_definitions
end
