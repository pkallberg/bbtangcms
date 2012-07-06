class CmsRole < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments
  has_many :assign_permits, :dependent => :destroy, :uniq => true
  has_many :cms_role_permits, :dependent => :destroy, :uniq => true
  #has_many :permits, :through => :assign_permits
  before_save :set_limit_role

  validates :name, :presence => true, :uniqueness => true

  def set_assign_permits_list (assign_permit_list = [])
    if assign_permit_list.present? and assign_permit_list != [""]
      self.assign_permits.destroy_all
      assign_permit_list.each do |permit_id|
        self.assign_permits.create( permit_id: permit_id) if Permit.exists? permit_id
      end
    else
      self.assign_permits = []
    end
  end
  def set_cms_role_permits_list (cms_role_permits = [])

    if cms_role_permits.present? and cms_role_permits != [""]
      self.cms_role_permits.destroy_all
      cms_role_permits.each do |permit_id|
        self.cms_role_permits.create(permit_id: permit_id) if Permit.exists? permit_id
      end
    else
      self.cms_role_permits = []
    end
  end
  #limit user ["guest","editor","operator"]
  def set_limit_role
    if ["guest","editor","operator"].include? self.name
      self.assign_permits = []
    end
  end

  def admin?
    true if self.name.to_s.include? "admin"
  end


  def supper_admin?
    true if self.name.to_s == "admin"
  end

  def to_s
    self.name if self.name.present?
  end

end
