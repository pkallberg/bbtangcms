class CrPermit < ActiveRecord::Base
  belongs_to :cms_role
  belongs_to :permit
  validates :cms_role_id, :permit_id, :presence => true
  #这是单表继承的父类 唯一就放到 子类里面去做了
  #validates_uniqueness_of [:cms_role_id, :permit_id]
  
end
