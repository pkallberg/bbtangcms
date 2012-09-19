# encoding: utf-8
=begin
Recommend::ExpertCategory
  init with some date special gave
  expert_category
    name
    sort_index (limit count), per must uniq value in (1 .. count)  count(default is 5) set by code
    timestamps

  can crud by special  user

profile.expert_category_list
  user can only check some expert_category gave
    can select within
      if profile.expert_categories.present?
        profile.expert_categories.map(&:name).concat(Recommend::ExpertCategory.all.entries.map(&:name))
      else
        Recommend::ExpertCategory.all.map(&:name)
      end
=end
class Recommend::ExpertCategory
  include Mongoid::Document
  #include Mongoid::Timestamps::Created
  include Mongoid::Timestamps

  validates_uniqueness_of :sort_index,:allow_nil => true,:allow_blank => true
  validates :sort_index, numericality: { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5 },:allow_nil => true,:allow_blank => true
  #validates :sort_index, uniqueness: true
  validates_uniqueness_of :name


  field :name, type: String
  field :sort_index, type: Integer



  def to_s
    "#{self.name}" if self.name.present?
  end
end
