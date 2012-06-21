# encoding: utf-8
class Recommend::RecommendSubject
  include Mongoid::Document

  field :position, type: String
  field :name, type: String
  field :body, type: String
  field :ids, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  # 0: <20, 1: 20< <=25 , 2: 25< <=30, 3: 30< <=35, 4: 35< <=40, 5: 40<
  P1  = "question_1"
  P2  = "question_2"
  P3  = "question_3"
  P4  = "question_4"
  P5  = "knowledge_1"

  POSITION = {
    P1        => "#{I18n.t('mongoid.attributes.recommend/recommend_subject.p1')}",
    P2     => "#{I18n.t('mongoid.attributes.recommend/recommend_subject.p2')}",
    P3     => "#{I18n.t('mongoid.attributes.recommend/recommend_subject.p3')}",
    P4     => "#{I18n.t('mongoid.attributes.recommend/recommend_subject.p4')}",
    P5     => "#{I18n.t('mongoid.attributes.recommend/recommend_subject.p5')}",

  }

  validates_inclusion_of :position, :in => POSITION.keys, :allow_nil=>true,
      :message => "{{value}} must be in #{POSITION.values.join ','}"

  def set_ids
    self.ids = self.body.to_s.split(/，|,|;|；|\ +|\||\r\n/).collect{|q| q.split("/").last}.join(",") if self.body
  end

  # just a helper method for the view
  def post_name
    POSITION[self.position.to_s]
  end
end
