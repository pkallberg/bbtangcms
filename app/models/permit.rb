class Permit < ActiveRecord::Base
  has_many :cu_permits
  has_many :cr_permits
  has_many :assign_permits
  has_many :cms_role_permits
  has_many :users, :through => :cu_permits
  validates :name, :presence => true, :uniqueness => true

  def to_s
    self.name if self.name.present?
  end
end
