class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :cms_role
  validates_uniqueness_of [:user_id, :cms_role_id]
end
