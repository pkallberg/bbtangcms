class Profile < ActiveRecord::Base
  #include Recommendation::Search
  #belongs_to :user
  belongs_to :user,
    :class_name    => '::User', # note I added '::'
    :foreign_key   => 'user_id'
  belongs_to :level
  has_many :tasks
  belongs_to :user_data_statistic

  has_many :r_user_knowledges
  has_many :knowledges,:through => :r_user_knowledges

  #attr_accessible :oauth_face_image_url # for getter and setters

  define_index do
   indexes nickname
   indexes real_name
   #声明使用实时索引
   set_property :delta => true
  end

  # 关联user_data_statistic， 直接使用字段, except service attributes like created_at, updated_at, etc.
  # delegate_attributes :to => :user_data_statistic
  def loaded_user_data_statistic?
    true
  end

  # 关联level， 直接使用level name
  # delegate_attributes :name, :to => :level

  #validates :nickname, :real_name, :length => {
  validates :nickname,  :length => {
    #:minimum => Askjane::MetaCache.get_config_data("profile_name_min").to_i,
    :maximum => Askjane::MetaCache.get_config_data("profile_name_max").to_i}
  validates :label, :profession, :length => {:maximum => Askjane::MetaCache.get_config_data("profile_label_max").to_i}

  #fixed bug, 当使用delegate_attributes的时候， 会需要loaded_[model]的方法
  def loaded_level?
    true
  end

  #profile_face_url = Askjane::MetaCache.get_config_data("profile_face_url")
  profile_face_url = "/uploadfiles/:class/:attachment/:id/:style/:filename"
  #    #profile_face_path = Askjane::MetaCache.get_config_data("profile_face_path")
  profile_face_path =":rails_root/public/uploadfiles/:class/:attachment/:id/:style/:filename"

  attr_accessible :face, :nickname, :gender, :agerange,
                  :pregnancy_status, :pregnancy_timeline,
                  :city, :child_birthday, :child_gender,
                  :user_id, :notify_via_email, :notify_on_new_articles,
                  :notify_on_comments,:oauth_face_image_url,
                  :baby_gender
  #profile_face_url = Askjane::MetaCache.get_config_data("profile_face_url")
  profile_face_url = "/uploadfiles/:class/:attachment/:id/:style/:filename"
  #profile_face_path = Askjane::MetaCache.get_config_data("profile_face_path")
  profile_face_path =":rails_root/public/uploadfiles/:class/:attachment/:id/:style/:filename"
  has_attached_file :face,:default_url => "/assets/face/:style/missing.png",
    :default_style => :s120,
    :styles => {
      :normal => "180x180#",
      :s120 => "120x120#",
      :s48 => "48x48#",
      :s32 => "32x32#",
      :s16 => "16x16#"
      },
    :url => profile_face_url,
    :path => profile_face_path

  #validates_attachment :face, :presence => true,
  validates_attachment :face,
                       :content_type => {:content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/bmp']}, :allow_nil=>true
                       #:size => { :in => 0..2.megabytes }

  #validates :face, :attachment_presence => true
  #validates_with AttachmentPresenceValidator, :attributes => :face
  validates_attachment_size :face, :less_than => 2.megabytes,
                          :unless => Proc.new {|m| m[:face].nil?}

  before_post_process :image?
  def image?
    #breakpoint
    !((self.face.content_type =~ /^image\/*/).nil?)
  end
  # 0: <20, 1: 20< <=25 , 2: 25< <=30, 3: 30< <=35, 4: 35< <=40, 5: 40<
  A20     = 0
  A20_25  = 1
  A25_30  = 2
  A30_35  = 3
  A35_40  = 4
  A40     = 5

  AGERANGE = {
    A20        => "#{I18n.t('activerecord.profiles.agerange.A20')}",
    A20_25     => "#{I18n.t('activerecord.profiles.agerange.A20_25')}",
    A25_30     => "#{I18n.t('activerecord.profiles.agerange.A25_30')}",
    A30_35     => "#{I18n.t('activerecord.profiles.agerange.A30_35')}",
    A35_40     => "#{I18n.t('activerecord.profiles.agerange.A35_40')}",
    A40        => "#{I18n.t('activerecord.profiles.agerange.A40')}",
  }

  validates_inclusion_of :agerange, :in => AGERANGE.keys, :allow_nil=>true,
      :message => "{{value}} must be in #{AGERANGE.values.join ','}"

  # just a helper method for the view
  def age_range
    AGERANGE[agerange.to_i]
  end

  #1: 未婚 2: 已婚未孕 3: 怀孕进行时 4 :宝贝计划
  UNMARRIED     = 1
  MARRIEDNONPREGNANT  = 2
  PREGNANTING  = 3
  BABYPLAN  = 4

  PRENGNANCYSTATUS = {
    UNMARRIED        => "#{I18n.t('activerecord.profiles.pregnancy_status.unmarried')}",
    MARRIEDNONPREGNANT     => "#{I18n.t('activerecord.profiles.pregnancy_status.married-non-pregnant')}",
    PREGNANTING     => "#{I18n.t('activerecord.profiles.pregnancy_status.pregnanting')}",
    BABYPLAN     => "#{I18n.t('activerecord.profiles.pregnancy_status.baby-plan')}",
  }

  validates_inclusion_of :pregnancy_status, :in => PRENGNANCYSTATUS.keys, :allow_nil=>true,
      :message => "{{value}} must be in #{PRENGNANCYSTATUS.values.join ','}"

  # just a helper method for the view
  def pregnancystatus
    PRENGNANCYSTATUS[pregnancy_status.to_i]
  end


  TIMELINE1  = 1
  TIMELINE2  = 2
  TIMELINE3  = 3
  TIMELINE4  = 4
  TIMELINE5  = 5

  PRENGNANCYTIMELINE = {
    TIMELINE1        => "#{I18n.t('activerecord.profiles.pregnancy_timeline.timeline1')}",
    TIMELINE2     => "#{I18n.t('activerecord.profiles.pregnancy_timeline.timeline2')}",
    TIMELINE3     => "#{I18n.t('activerecord.profiles.pregnancy_timeline.timeline3')}",
    TIMELINE4     => "#{I18n.t('activerecord.profiles.pregnancy_timeline.timeline4')}",
    TIMELINE5     => "#{I18n.t('activerecord.profiles.pregnancy_timeline.timeline5')}",
  }

  validates_inclusion_of :pregnancy_timeline, :in => PRENGNANCYTIMELINE.keys, :allow_nil=>true,
      :message => "{{value}} must be in #{PRENGNANCYTIMELINE.values.join ','}"

  # just a helper method for the view
  def pregnancytimeline
    PRENGNANCYTIMELINE[pregnancy_timeline.to_i]
  end

  #the display name which will be userd in pages
  def display_name
    if self.nickname?
      self.nickname
    else
      #if no nickname, show account name
      User.find_by_id(self.user_id).username
    end
  end

  # add like tag for this user
  def add_like
    if self.like_by_count.blank?
      self.like_by_count = 1
    else
      self.like_by_count = self.like_by_count + 1
    end
  end

  # remove like tag from this user
  def remove_like
    if self.like_by_count.blank?
      self.like_by_count = 1
    else
      self.like_by_count = self.like_by_count - 1
    end
  end

  #判断该user是否被关注
  def has_focus_user_on?(user_id)
    if !self.focus_user_on.blank? && !user_id.blank?
       self.focus_user_on_to_array.include?(user_id)
    else
      false
    end
  end

  #判断该user是关注了某人
  def has_focus_user_by?(user_id)
    if !self.focus_user_by.blank? && !user_id.blank?
      self.focus_user_by_to_array.include?(user_id)
    else
      false
    end
  end

  #判断是否互相关注
  def has_concern_each?(user_id)
    on = self.focus_user_on_to_array
    by = self.focus_user_by_to_array
    focus_users =  on & by
    if not focus_users.empty? and not user_id.blank?
      focus_users.include?(user_id)
    else
      false
    end
  end

  #返回添加了会员id的focus_user_on字段
  def focus_user_on_after_added(user_id)
    current_profile = Profile.find_by_id(self.id)
    result = ''
    if current_profile.focus_user_on.blank?
      result = user_id.to_s
    else
      result << current_profile.focus_user_on.to_s << "," << user_id.to_s
    end
  end

  #返回添加了会员id的focus_user_by字段
  def focus_user_by_after_added(user_id)
    current_profile = Profile.find_by_id(self.id)
    result = ''
    if current_profile.focus_user_by.blank?
      result = user_id.to_s
    else
      result << current_profile.focus_user_by.to_s << "," << user_id.to_s
    end
  end

  #返回删除了会员id的focus_user_by字段
  def focus_user_by_after_removed(user_id)
    @focus_user_by = Profile.find_by_id(self.id).focus_user_by_to_array
    @focus_user_by.delete(user_id)
    @focus_user_by.join(',')
  end

  #返回删除了会员id的focus_user_on字段
  def focus_user_on_after_removed(user_id)
    @focus_user_on = Profile.find_by_id(self.id).focus_user_on_to_array
    @focus_user_on.delete(user_id)
    @focus_user_on.join(',')
  end

  #把字符串转化成数组
  def focus_user_by_to_array
    if self.focus_user_by.blank?
      return []
    else
      self.focus_user_by.split(",").map {|a| a.to_i}
    end
  end

  #把字符串转化成数组
  def focus_user_on_to_array
    if self.focus_user_on.blank?
      return []
    else
      self.focus_user_on.split(",").map {|a| a.to_i}
    end
  end

  # 返回推荐认识的人的集合(尚未剔除已经关注的，尚未加入管理员定义的)
  def deserve_to_focus
    redis = Askjane::DefineRedis.define_recommendation_redis(Recommendation::Search.config.namespace,"deserve_to_focus")
    s = redis.zrange self.id,0,-1
    ids = []
    s.each do |t|
      ids << t.to_i
    end
    return ids
  end

  # 该用户的所有完成的tasks
  def done_tasks
     self.tasks.where(:done => true).order("updated_at DESC")
  end

  # 该用户的未完成的tasks
  def pending_tasks
     self.tasks.where(:done => false).order("updated_at DESC")
  end

  # 该用户的所有的tasks
  def all_tasks
     self.tasks.order("updated_at DESC")
  end


  # 该用户最近更新的相册
  def latest_album
    Album.where(:created_by => self.user_id, :private=>false, :deleted_at => nil).order("updated_at DESC").first
  end

  # 推送新朋友
  def user_new_friends
    # TODO: need to use recommendation
    Profile.all
  end

  # 推送专家
  def user_recommendation_talents(limit=nil)
    # TODO: need to use recommendation
    Talent.talents.limit(limit||=Askjane::MetaCache.get_config_data("user_home_list_pre_block").to_i)
  end

  # 推送达人
  def user_recommendation_experts(limit=nil)
    # TODO: need to use recommendation
    Expert.experts.limit(limit||=Askjane::MetaCache.get_config_data("user_home_list_pre_block").to_i)
  end

  # 推送groups category
  def user_recommendation_for_group_categories(limit=nil)
    # TODO: need to use recommendation
    GroupCategory.limit(limit||=Askjane::MetaCache.get_config_data("user_home_list_pre_block").to_i)
  end


  # 推送groups
  def user_recommendation_for_groups(category, limit=nil)
    # TODO: need to use recommendation
    GroupCategory.find_by_id(category).groups.limit(limit||=Askjane::MetaCache.get_config_data("user_home_list_pre_block"))
  end

  # 当前用登录后个人页面，  您关注的专家帮手正在说 相关数据
  def user_home_topics_of_experts(limit=nil)
    return [] if self.focus_user_on.blank?
    limit ||= Askjane::MetaCache.get_config_data("user_home_list_pre_block")
    Topic.find_by_sql("SELECT t.* FROM topics t                          \
                        LEFT JOIN profiles p                              \
                        ON t.created_by = p.user_id                                \
                        WHERE t.created_by in (#{self.focus_user_on})         \
                        AND p.id = 3                                           \
                        AND t.created_at >= #{Date.today-Askjane::MetaCache.get_config_data("user_home_list_more_than_day").to_i} \
                        ORDER BY t.created_at DESC                              \
                        LIMIT #{limit}")
  end

  # 当前用登录后个人页面，  您关注的圈子正在说 相关数据
  def user_home_topics_of_talents(limit=nil)
    return [] if self.focus_user_on.blank?
    limit ||= Askjane::MetaCache.get_config_data("user_home_list_pre_block")
    Topic.find_by_sql("SELECT t.* FROM topics t                          \
                        LEFT JOIN profiles p                              \
                        ON t.created_by = p.user_id                              \
                        WHERE t.created_by in (#{self.focus_user_on})         \
                        AND p.id = 2                                           \
                        AND t.created_at >= #{Date.today-Askjane::MetaCache.get_config_data("user_home_list_more_than_day").to_i} \
                        ORDER BY t.created_at DESC                              \
                        LIMIT #{limit}")
  end

  # 当前用登录后个人页面，  您关注的圈子正在说 相关数据
  def user_home_topics_of_groups(limit=nil)
    return [] if self.focus_group_on.blank?
    limit ||= Askjane::MetaCache.get_config_data("user_home_list_pre_block")
    Topic.find_by_sql("SELECT t.* FROM topics t                          \
                        WHERE t.group_id in (#{self.focus_group_on})      \
                        AND t.created_at >= #{Date.today-Askjane::MetaCache.get_config_data("user_home_list_more_than_day").to_i} \
                        ORDER BY t.created_at DESC                         \
                        LIMIT #{limit}")
  end

  # 当前用登录后个人页面，  您关注的问题 相关数据
  def user_home_questions(limit=nil)
    return [] if self.focus_question_on.blank?
    limit ||= Askjane::MetaCache.get_config_data("user_home_list_pre_block")
    Question.find_by_sql("SELECT q.* FROM questions q                          \
                          WHERE q.id in (#{self.focus_question_on})      \
                          AND q.created_at >= #{Date.today-Askjane::MetaCache.get_config_data("user_home_list_more_than_day").to_i} \
                          ORDER BY q.created_at DESC                         \
                          LIMIT #{limit}")
  end

  # 最新问题
  def user_latest_questions(limit=nil)
    limit ||= Askjane::MetaCache.get_config_data("user_home_list_pre_block")
    Question.find_by_sql("SELECT q.* FROM questions q                          \
                          WHERE q.created_at >= #{Date.today-Askjane::MetaCache.get_config_data("user_home_list_more_than_day").to_i} \
                          ORDER BY q.created_at DESC                         \
                          LIMIT #{limit}")
  end

  # 最新回答
  def user_latest_questions(limit=nil)
    limit ||= Askjane::MetaCache.get_config_data("user_home_list_pre_block")
    Question.find_by_sql("SELECT q.* FROM questions q                          \
                          WHERE q.last_answer_time >= #{Date.today-Askjane::MetaCache.get_config_data("user_home_list_more_than_day").to_i} \
                          ORDER BY q.last_answer_time DESC                         \
                          LIMIT #{limit}")
  end

  # 当月电子杂志
  def user_ezine_current
    Ezine.ezine_first
  end

  #往期电子杂志
  def user_ezines_before
    Ezine.ezines_before
  end

  # 顶得最多
  def user_most_supports
    #TODO: not define this column
    Question.limit(4)
  end
  # 与该用户相关的任务
  def user_tasks
    Task.where(:created_by => self.user_id).order("updated_at DESC")
  end

  #全部关注的数目
  def attentions_count
    (attentions.empty?)?0:attentions.count
  end

  # 互相关注的数目
  def att_friend_count
    (att_friend.empty?)?0:att_friend.count
  end

  # 粉丝数目
  def fans_count
    (fans.empty?)?0:fans.count
  end

  # 全部关注的人
  def attentions
    result = []
    focus_users = self.focus_user_on_to_array
    result = Profile.all(:conditions => ["user_id in (?)", focus_users]) unless focus_users.empty?
    result
  end

  # 互相关注的人
  def att_friend
    result = []
    on = self.focus_user_on_to_array
    by = self.focus_user_by_to_array
    focus_users =  on & by
    result = Profile.all(:conditions => ["user_id in (?)", focus_users]) unless focus_users.empty?
    result
  end

  # 关注我的人
  def fans
    result = []
    #on = self.focus_user_on_to_array
    #by = self.focus_user_by_to_array
    #att_friends =  on & by
    focus_users = self.focus_user_by_to_array #- att_friends
    result = Profile.all(:conditions => ["user_id in (?)", focus_users]) unless focus_users.empty?
    result
  end

  # 通过nickname查找朋友
  def self.find_friends_via_nickname(search_text)
    result = []
    result = ThinkingSphinx::Search.search("@nickname "<<search_text<<" | @real_name "<<search_text, :class => [Profile],:match_mode  => :extended)

  end

  # 专家？
  def is_expert?
    self.level_id == 3 ? true : false
  end

end
