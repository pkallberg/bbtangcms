class CuPermit < ActiveRecord::Base
  belongs_to :user
  belongs_to :permit
  validates  :user_id, :permit_id, :presence => true
  #uniqueness permit_id for user_id
  validates_uniqueness_of :permit_id, :scope => :user_id
end
