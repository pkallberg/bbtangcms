# encoding: utf-8
class User < ActiveRecord::Base
  establish_connection :auth
  # Include default devise modules. Others available are:
  has_many :assignments, :dependent => :destroy, :uniq => true
  has_many :cms_roles, :through => :assignments

  has_many :cu_permits, :dependent => :destroy, :uniq => true
  has_many :permits, :through => :cu_permits # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :lockable, :recoverable,
         :rememberable, :registerable, :trackable, :timeoutable, :validatable,
         :token_authenticatable
  has_one :profile, :class_name => "Profile"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessor :agree
  validates_acceptance_of :agree, :message => I18n.t("must_be_agree")
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
             :remember_me, :username, :login, :agree,:cms_role_ids,:permit_ids

  #before_validation :update_user_permit

  #生成邀请link
  def invitations_link
    Askjane::MetaCache.get_config_data("default_website_url") + "/users/invitations/accept?user_id=" + self.id.to_s
  end

  #通过用户email判断是否是我们的会员
  def self.is_member_with_email?(email)
    (User.find_by_email(email).blank?) ? false : true
  end

  def to_s
    if self.profile && self.profile.nickname.present?
      self.profile.nickname
    else
      self.username.present? ? self.username : self.email
    end
  end

  def has_cms_role?(cms_role_sym)
    cms_roles.any? { |r| r.name.underscore.to_sym == cms_role_sym }
  end

  def admin_group?
    tmp = false
    if self.cms_roles.present?
      self.cms_roles.each do |cms_role|
        if cms_role.name.to_s.include? "admin" and not cms_role.supper_admin?
          tmp = true
        end
      end
    end
    tmp
  end

  def limit_admin_group?
    tmp = false
    if self.cms_roles.present?
      self.cms_roles.each do |cms_role|
        if cms_role.name.to_s.include? "admin"
          tmp = true
        end
      end
    end
    tmp
  end

  def admin_group
    self.cms_roles.collect {|cms_role| cms_role if cms_role.admin? }.compact
  end

  def owner_users(name = nil)
    owner_user = []
    if self.admin_group? and name.present?
      User.all.each do |u|
        if (u.cms_roles.map(&:name).include? name.gsub("admin",'')) and not u.admin_group?

          owner_user.append u
        end
      end
    end
    owner_user.uniq
  end

  def supper_admin
    self.cms_roles.each do |cms_role|
      cms_role.to_s.include? "admin"
    end
  end

  def admin_assign_permits(cms_role = nil)
    admin_assign_permits = []
    if cms_role.present? and self.cms_roles.include? cms_role and cms_role.admin?
      cms_role.assign_permits.each do |assign_permit|
        admin_assign_permits.append assign_permit.permit if assign_permit.permit.present?
      end
      admin_assign_permits
    else
      admin_assign_permits
    end
  end

  def update_user_permit(new_cms_role_ids = [])

    new_cms_role_ids.collect!{|new_cms_role_id| new_cms_role_id.to_i if new_cms_role_id.present?}.compact!

    if self.cms_role_ids.sort != new_cms_role_ids.sort
      self.permits = []
    end
  end

end
