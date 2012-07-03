class CuPermit < ActiveRecord::Base
  belongs_to :user
  belongs_to :permit
  validates  :user_id, :permit_id, :presence => true
end
