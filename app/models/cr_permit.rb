class CrPermit < ActiveRecord::Base
  belongs_to :cms_role
  belongs_to :permit
  validates :cms_role_id, :permit_id, :presence => true
end
