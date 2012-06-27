class CategoryBase < ActiveRecord::Base
  include BaseModel  #for 敏感词验证
  acts_as_nested_set
  attr_accessible :name, :parent_id, :description
  
  acts_as_taggable_on :tags

  validates :name, :presence => true
  
  before_save :auto_add_description
  
  private
  def auto_add_description
     self.description = "description for #{self.name}" if self.description =nil or self.description = ''
  end
  
end