# encoding: utf-8
class Recommend::RecommendTag
  include Mongoid::Document

  field :position, type: String
  field :name, type: String
  field :body, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  # 0: <20, 1: 20< <=25 , 2: 25< <=30, 3: 30< <=35, 4: 35< <=40, 5: 40<
  P1  = "question_mom"
  P2  = "question_baby"
  P3  = "knowledge_baby"
  P4  = "knowledge_mom"


  POSITION = {
    P1        => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p1')}",
    P2     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p2')}",
    P3     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p3')}",
    P4     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p4')}",
    #A35_40     => "#{I18n.t('activerecord.profiles.agerange.A35_40')}",

  }

  validates_presence_of :name, :body
  validates_inclusion_of :position, :in => POSITION.keys, :allow_nil=>true,
      :message => "{%{value}} must be in #{POSITION.values.join ','}"

  validates :body, :presence => true, :if => Proc.new { |instance| ids_validator instance.body }

  def ids_validator(str=nil)
    ids = str.to_s.split(/，|,|;|；|\ +|\||\r\n/) if self.body
    ids.each do |tag|
      errors.add(:body, "Tag '#{tag}' is not exist") if CategoryBase.find(tag).nil?
    end
  end

  # just a helper method for the view
  def post_name
    POSITION[self.position.to_s]
  end
end
