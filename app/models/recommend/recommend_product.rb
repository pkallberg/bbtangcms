class Recommend::RecommendProduct
  include Mongoid::Document

  field :position, type: String
  field :name, type: String
  field :image, type: String
  field :title, type: String
  field :price, type: Float
  field :cnt_buy, type: Integer
  field :cnt_comment, type: Integer
  field :link_url, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime
end
