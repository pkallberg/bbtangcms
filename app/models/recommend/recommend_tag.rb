# encoding: utf-8
class Recommend::RecommendTag
  include Mongoid::Document

  field :position, type: String
  field :name, type: String
  field :body, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime
  #before_save :set_tags
  
  # 0: <20, 1: 20< <=25 , 2: 25< <=30, 3: 30< <=35, 4: 35< <=40, 5: 40<
  P1  = "question_mom"
  P2  = "question_baby"
  P3  = "knowledge_baby"
  P4  = "knowledge_mom"
  P5  = "knowledge_index1"
  P6  = "knowledge_index2"
  P7  = "bbtang_keywords"


  POSITION = {
    P1        => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p1')}",
    P2     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p2')}",
    P3     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p3')}",
    P4     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p4')}",
    P5     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p5')}",
    P6     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p6')}",
    P7     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p7')}"
    #A35_40     => "#{I18n.t('activerecord.profiles.agerange.A35_40')}",

  }

  validates_presence_of :body
  validates_inclusion_of :position, :in => POSITION.keys, :allow_nil=>true,
      :message => "{%{value}} must be in #{POSITION.values.join ','}"

  validates :body, :presence => true, :if => Proc.new { |instance| ids_validator(instance.body,skip = (position.eql? "bbtang_keywords") ? true : false) }

  def ids_validator(str=nil, skip = false)
    tags = str.to_s.split_all.collect {|t| t if t.present?}.uniq.compact if self.body
    
    self.body = tags.join(",") if tags.present?
    
    unless skip
      tags.each do |tag|
        #errors.add(:body, "Tag '#{tag}' is not exist") unless CategoryBase.find_by_name(tag).present?
        errors.add(:body, "Tag '#{tag}' is not exist") unless ActsAsTaggableOn::Tag.find_by_name(tag).present?
      end
    end
  end
  
  def set_tags
    self.body = body.split_all.join(",") if self.body.present?
  end

  # just a helper method for the view
  def post_name
    POSITION[self.position.to_s]
  end
end
