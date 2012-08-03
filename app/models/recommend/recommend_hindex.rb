# encoding: utf-8
class Recommend::RecommendHindex
  include Mongoid::Document

  field :name, type: String
  field :body, type: String
  field :position, type: String
  field :color, type: String
  field :deleted, type: Boolean
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  # 0: <20, 1: 20< <=25 , 2: 25< <=30, 3: 30< <=35, 4: 35< <=40, 5: 40<
  P1  = "01"
  P2  = "02"
  P3  = "03"
  P4  = "04"
  P5  = "05"
  P6  = "06"
  P7  = "07"
  P8  = "08"
  P9  = "09"
  P10  = "10"
  P11  = "11"
  P12  = "12"

  C1  = "id_nv01"
  C2  = "id_nv02"
  C3  = "id_nv03"
  C4  = "id_nv04"


  POSITION = {
    P1        => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p1')}",
    P2     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p2')}",
    P3     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p3')}",
    P4     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p4')}",
    P5     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p5')}",
    P6     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p6')}",
    P7     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p7')}",
    P8     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p8')}",
    P9     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p9')}",
    P10     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p10')}",
    P11     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p11')}",
    P12     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.p12')}",
  }



  validates_presence_of :body

  validates_inclusion_of :position, :in => POSITION.keys, :allow_nil=>true,
      :message => "{%{value}} must be in #{POSITION.values.join ','}"

  # just a helper method for the view
  def post_name
    POSITION[self.position.to_s]
  end

  COLOR = {
    C1        => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.c1')}",
    C2     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.c2')}",
    C3     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.c3')}",
    C4     => "#{I18n.t('mongoid.attributes.recommend/recommend_hindex.c4')}",


  }

  validates_inclusion_of :color, :in => COLOR.keys, :allow_nil=>true,
      :message => "{%{value}} must be in #{COLOR.values.join ','}"

  # just a helper method for the view
  def color_name
    COLOR[self.color.to_s]
  end
end
