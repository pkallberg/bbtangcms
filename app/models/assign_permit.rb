class AssignPermit < CrPermit
  validates_uniqueness_of [:cms_role_id, :permit_id]
end
