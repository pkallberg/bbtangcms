# encoding: utf-8
class Recommend::OtherColumn
  include Mongoid::Document
  #include Mongoid::Timestamps::Created
  include Mongoid::Timestamps

  field :recommend_type, type: String
  #field :other_column_hash, type: Array#[human_name , colmun_name]
  field :human_names, type: Array #[human_name1 , human_name2, human_name3]
  field :column_names, type: Array #[colmun_name1 , colmun_name2, colmun_name3]
  before_validation :set_array

  validates_uniqueness_of :recommend_type


  def set_array
    self.human_names = convert_array(self.human_names)
    self.column_names = convert_array(self.column_names)
  end

  def convert_array(str=nil)
    if str.present?
     str = str.to_s.split(/，|,|;|；|\ +|\||\r\n/).collect {|t| t if t.present?}.uniq.compact
    else
      []
    end
  end

=begin
  def dynamic_attributes
    self.attributes.delete_if { |attribute|
      self.fields.keys.member? attribute
    }
  end
=end
end
