class CuPermit < ActiveRecord::Base
  belongs_to :user
  belongs_to :permit
  validates  :user_id, :permit_id, :presence => true
  validates_uniqueness_of [:user_id, :permit_id]
end
