class Recommend::RecommendApp
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :position, type: String
  field :body, type: String

  validates_presence_of :position, :body

  def to_s
    "#{Recommend::RecommendApp.model_name.human} #{position} #{name}".strip
  end
end
