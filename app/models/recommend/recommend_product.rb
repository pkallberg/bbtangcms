# encoding: utf-8
class Recommend::RecommendProduct
  include Mongoid::Document

  field :position, type: String
  field :order, type: String
  field :image, type: String
  field :title, type: String
  field :price, type: Float
  field :cnt_buy, type: Integer
  field :cnt_comment, type: Integer
  field :link_url, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  # 0: <20, 1: 20< <=25 , 2: 25< <=30, 3: 30< <=35, 4: 35< <=40, 5: 40<
  P1  = "question"
  P2  = "knowledge"
  #P3  = "question_3"
  #P4  = "question_4"
  #P5  = "knowledge_1"

  POSITION = {
    P1        => "#{I18n.t('mongoid.attributes.recommend/recommend_product.p1')}",
    P2     => "#{I18n.t('mongoid.attributes.recommend/recommend_product.p2')}",
    #P3     => "#{I18n.t('mongoid.attributes.recommend/recommend_product.p3')}",
    #P4     => "#{I18n.t('mongoid.attributes.recommend/recommend_product.p4')}",
    #P5     => "#{I18n.t('mongoid.attributes.recommend/recommend_product.p5')}",

  }
  validates_presence_of :order, :image, :title, :price, :link_url
  validates_inclusion_of :position, :in => POSITION.keys, :allow_nil=>true,
      :message => "{%{value}} must be in #{POSITION.values.join ','}"

  def set_ids
    self.ids = self.body.to_s.split(/，|,|;|；|\ +|\||\r\n/).collect{|q| q.split("/").last}.join(",") if self.body
  end

  # just a helper method for the view
  def post_name
    POSITION[self.position.to_s]
  end
end
