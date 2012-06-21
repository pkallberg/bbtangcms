class Recommend::RecommendUser
  include Mongoid::Document

  field :position, type: String
  field :name, type: String
  field :body, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  # 0: <20, 1: 20< <=25 , 2: 25< <=30, 3: 30< <=35, 4: 35< <=40, 5: 40<
  P1  = "front_page_experts"
  P2  = "right_panel_experts"
  P3  = "right_panel_moms"
  #P4  = "knowledge_1"
  #P5  = "knowledge_2"

  POSITION = {
    P1        => "#{I18n.t('mongoid.attributes.recommend/recommend_user.p1')}",
    P2     => "#{I18n.t('mongoid.attributes.recommend/recommend_user.p2')}",
    P3     => "#{I18n.t('mongoid.attributes.recommend/recommend_user.p3')}",
    #P4     => "#{I18n.t('mongoid.attributes.recommend/recommend_quiz.p4')}",
    #P5     => "#{I18n.t('mongoid.attributes.recommend/recommend_quiz.p5')}",

  }

  validates_inclusion_of :position, :in => POSITION.keys, :allow_nil=>true,
      :message => "{{value}} must be in #{POSITION.values.join ','}"


  # just a helper method for the view
  def post_name
    POSITION[self.position.to_s]
  end
end
