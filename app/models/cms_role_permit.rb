class CmsRolePermit < CrPermit
  #uniqueness permit_id for each cms_role_id
  validates_uniqueness_of :permit_id, :scope => :cms_role_id
end
