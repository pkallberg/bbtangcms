class Recommend::RecommendEvent
  include Mongoid::Document

  field :position, type: String
  field :name, type: String
  field :body, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime
end
