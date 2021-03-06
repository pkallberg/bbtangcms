class Recommend::RecommendQuestion
  include Mongoid::Document

  field :position, type: String
  field :name, type: String
  field :body, type: String
  field :body_knowledge, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  # 0: <20, 1: 20< <=25 , 2: 25< <=30, 3: 30< <=35, 4: 35< <=40, 5: 40<
  P1  = "front_page_questions"
  #P2  = "question_baby"
  #P3  = "knowledge_baby"
  #P4  = "knowledge_mom"


  POSITION = {
    P1        => "#{I18n.t('mongoid.attributes.recommend/recommend_question.p1')}",
    #P2     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p2')}",
    #P3     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p3')}",
    #P4     => "#{I18n.t('mongoid.attributes.recommend/recommend_tag.p4')}",
    #A35_40     => "#{I18n.t('activerecord.profiles.agerange.A35_40')}",

  }

  validates_inclusion_of :position, :in => POSITION.keys, :allow_nil=>true,
      :message => "{{value}} must be in #{POSITION.values.join ','}"

  # just a helper method for the view
  def post_name
    POSITION[self.position.to_s]
  end
end
