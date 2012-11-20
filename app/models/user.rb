# encoding: utf-8
class User < ActiveRecord::Base
  scope :level, ->(level_id) {joins(:profile).where('profiles.level_id = ?', level_id)}
  scope :daren, joins(:profile).where('profiles.level_id = ?', 2)
  scope :expert, joins(:profile).where('profiles.level_id = ?', 3)
  #param = {provider: "sina", uid: "1572620462"}
  #User.authorization(provider: "sina", uid: "1572620462")
  scope :authorization, ->(param) {joins(:authorizations).readonly(false).where(['authorizations.provider = ? and authorizations.uid = ?', param[:provider],param[:uid]])}
  #get user by give special authorizations.provider
  scope :users_source, ->(provider) {joins(:authorizations).where("authorizations.provider =?",provider)}

  has_many :authorizations, :dependent => :destroy
  has_many :messages
  include HasMessages
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

  attr_accessor :agree, :confirmation_now
  validates_acceptance_of :agree, :message => I18n.t("must_be_agree")
  #validates_acceptance_of :confirmation_now
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
             :remember_me, :username, :login, :agree,:cms_role_ids,
             :permit_ids, :confirmation_now

  #before_validation :update_user_permit
  before_save :if_confirmation_now
  #destroy associate event_log
  after_save :clear_event_log
  after_destroy :clear_event_log
  
  def clear_event_log
    #Eventlog.remove("item_id" => params[:id].to_i, "item_type"=>"Note")
    if (self.respond_to? :deleted_by and self.send(:deleted_by)) or not(self.class.exists? self.id)
      EventLog.where(item_type: self.class.to_s,item_id: id).collect{|event_log| event_log.destroy} if self.present?
    end
  end

  #生成邀请link
  def invitations_link
    BBTangCMS::MetaCache.get_config_data("default_website_url") + "/users/invitations/accept?user_id=" + self.id.to_s
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
  def admin_group
    self.cms_roles.collect {|cms_role| cms_role if cms_role.admin? }.compact
  end

  def admin_group?
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

  def limit_admin_group
    self.cms_roles.collect {|cms_role| cms_role if cms_role.admin? and !cms_role.supper_admin? }.compact
  end

  def limit_admin_group?
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

  def notes
    Note.where(created_by: self.id)
  end

  def questions
    Question.where(created_by: self.id)
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

  def supper_admin?
    tmp = false
    self.cms_roles.each do |cms_role|
      tmp = true if cms_role.to_s.eql? "admin"
    end
    tmp
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

  def if_confirmation_now
    if self.confirmation_now.present?
      self.skip_confirmation! if ["true","1",1,true].include? self.confirmation_now
    else
      self.confirmation_now = nil
    end
  end


  def is_cms_user?
    tmp = false
    if self.cms_roles.present?
      self.cms_roles.each do |cms_role|
        if cms_role.name.to_s.include? "guest" or CmsRole.all.include? cms_role
          tmp = true
        end
      end
    end
    return tmp
  end

  def current_user
    User.current = session[:user_id] ? User.find_by_id(session[:user_id]) : nil
  end

  def is_internal_user?
    internal_user = InternalUser.new
    internal_user.all_internal_email.include? self.email ? true : false
  end

  def current_sign_in_city
    change_ip_to_city(current_sign_in_ip) if current_sign_in_ip.present?
  end

  def last_sign_in_city
    change_ip_to_city(last_sign_in_ip) if last_sign_in_ip.present?
  end

  def is_new_one?
    sign_in_count.to_i.eql? 0
  end

  def create_oauth_user(param= {})
    if param[:provider].present? and param[:uid].present?
      ActiveRecord::Base.transaction do
        self.skip_confirmation! if not self.confirmed?
        self.save
        authorization = self.authorizations.new(provider: param[:provider], uid: param[:uid])
        authorization.save
      end
    end
  end

  def change_ip_to_city(ip=nil)
    is = IpSearch.new
    ip ||= "116.228.214.170"
    is.find_ip_location(ip)
    #breakpoint
    #return is.country.gsub("市","")
    is.country.split("省").last.gsub("市","")
  end

  class << self
    def straight_users
      #find_by_sql("select * from users where not exists (SELECT authorizations.user_id FROM authorizations where (users.id = authorizations.user_id)) order by id")
      where("id not in (SELECT authorizations.user_id FROM authorizations where (users.id = authorizations.user_id))")
    end
  
    ["sina", "tqq", "qq_connect", "mmbkoo"].each do |provider|
      define_method("#{provider}_users"){
        users_source(provider)
    }
    end
    
    def authorizations_all
      find_by_sql("select * from users where exists (SELECT authorizations.user_id FROM authorizations where (users.id = authorizations.user_id)) order by id")
    end
    

    def no_mmbkoo_user_ids
      find_by_sql("select id from users where not exists (SELECT authorizations.user_id FROM authorizations WHERE (provider = 'mmbkoo' and users.id = authorizations.user_id)) order by id")
    end
=begin    
    def no_mmbkoo_users
      find_by_sql("select * from users where not exists (SELECT authorizations.user_id FROM authorizations WHERE (provider = 'mmbkoo' and users.id = authorizations.user_id)) order by id")
    end

=end
    #以id顺序的方式指定个数的非妈妈宝库用户记录
    def no_mmbkoo_with_limit(limit_count = 1000)
      find_by_sql("select * from users where not exists (SELECT authorizations.user_id FROM authorizations WHERE (provider = 'mmbkoo' and users.id = authorizations.user_id)) order by id limit #{limit_count}")
    end
  
    def internal_users
      internal_user = InternalUser.new
      emails = internal_user.all_internal_email
      emails.collect{|em| User.find_by_email em}.compact.uniq
    end
    def internal_user_ids
      internal_users.map(&:id)
    end
    def internal_user_emails
      internal_user = InternalUser.new
      emails = internal_user.all_internal_email
    end
  end
end
