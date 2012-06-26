class User < ActiveRecord::Base
  establish_connection :auth
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :lockable, :recoverable,
         :rememberable, :registerable, :trackable, :timeoutable, :validatable,
         :token_authenticatable
  has_one :profile, :class_name => "Profile"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessor :agree
  validates_acceptance_of :agree, :message => I18n.t("must_be_agree")
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login, :agree

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


end
