class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :cms_role
  #[:user_id, :cms_role_id] each will uniqueness
  #validates_uniqueness_of [:user_id, :cms_role_id]
  #uniqueness cms_role_id for each user_id
  validates_uniqueness_of :cms_role_id, :scope => :user_id
end
