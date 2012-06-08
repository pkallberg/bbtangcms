class User < ActiveRecord::Base
  establish_connection :auth
  include Redis::Search
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :authentication_keys => [:login]
  has_one :profile, :class_name => "Profile"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessor :login, :agree
  validates_acceptance_of :agree, :message => I18n.t("must_be_agree")
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login, :agree

  #email、用户名登录
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  #生成邀请link
  def invitations_link
    Askjane::MetaCache.get_config_data("default_website_url") + "/users/invitations/accept?user_id=" + self.id.to_s
  end

  #通过用户email判断是否是我们的会员
  def self.is_member_with_email?(email)
    (User.find_by_email(email).blank?) ? false : true
  end

  #begin! added by ivan, set the thread variable for current_user, then we will use current_use in model
  def self.current  
    Thread.current[:user]  
  end  
  
  def self.current=(user)  
    #raise(ArgumentError,  
    #    "Invalid user. Expected an object of class 'User', got #{user.inspect}") unless user.is_a?(User)  
    Thread.current[:user] = user  
  end  
  #end! added by ivan, set the thread variable for current_user, then we will use current_use in model

 def self.find_record(login)
   where(["username = :value OR email = :value", { :value => login }]).first
 end

end
