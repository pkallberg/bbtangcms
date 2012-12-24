class CategoryBase < ActiveRecord::Base
  has_paper_trail   # you can pass various options here
  acts_as_nested_set
  attr_accessible :name, :parent_id, :description

  acts_as_taggable_on :tags

  validates :name, :presence => true

  before_save :auto_add_description

  def to_s
    if self.name.present?
      self.name
    else
      self.id
    end
  end


  private
  def auto_add_description
     self.description = "description for #{self.name}" unless self.description.present?
  end

end
