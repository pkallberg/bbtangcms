# encoding: utf-8
class Recommend::RecommendQuiz
  include Mongoid::Document
  before_validation :set_ids
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
  P4  = "knowledge_1"
  P5  = "knowledge_2"

  POSITION = {
    P1        => "#{I18n.t('mongoid.attributes.recommend/recommend_quiz.p1')}",
    P2     => "#{I18n.t('mongoid.attributes.recommend/recommend_quiz.p2')}",
    P3     => "#{I18n.t('mongoid.attributes.recommend/recommend_quiz.p3')}",
    P4     => "#{I18n.t('mongoid.attributes.recommend/recommend_quiz.p4')}",
    P5     => "#{I18n.t('mongoid.attributes.recommend/recommend_quiz.p5')}",

  }

  validates_presence_of :name, :body

  validates_inclusion_of :position, :in => POSITION.keys, :allow_nil=>true,
      :message => "{%{value}} must be in #{POSITION.values.join ','}"

  validates :body, :presence => true, :if => Proc.new { |instance| ids_validator instance.body }

  def ids_validator(str=nil)
    ids = str.to_s.split(/，|,|;|；|\ +|\||\r\n/) if self.body
    ids.each do |quiz|
      errors.add(:body, "Quiz '#{quiz}' is not exist") if Quiz.find(quiz).nil?
    end
  end

  def set_ids
    self.ids = self.body.to_s.split(/，|,|;|；|\ +|\||\r\n/).collect{|q| q.split("/").last}.join(",") if self.body
  end

  # just a helper method for the view
  def post_name
    POSITION[self.position.to_s]
  end
end
