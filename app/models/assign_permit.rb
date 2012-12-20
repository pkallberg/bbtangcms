class AssignPermit < CrPermit
  #uniqueness permit_id for each user_id
  validates_uniqueness_of :permit_id, :scope => :user_id
end
