# coding: utf-8
class Knowledge< ActiveRecord::Base
    DEFAULT_LIMIT = 15

  include BaseModel  #for 敏感词验证
  acts_as_followable
  acts_as_taggable_on :tags, :timelines, :categories, :identities
  #before_validation :check_spam_words
  before_validation :repear_save

  belongs_to :knowledgebase_category
  has_one :quiz

  has_many :r_user_knowledges
  has_many :knowledges,:through => :r_user_knowledges
  attr_accessor :soft_deleted
  attr_accessible :title, :face, :summary, :body, :created_name,
                  :deleted_at, :source_info,
                  :views_count, :comments_count, :forwarding_count,
                  :thanks_count, :created_at, :updated_at,
                  :updated_by, :identity_list, :tag_list,
                  :created_by,:timeline_list,:category_list, :soft_deleted

  #knowledge_face_url = Askjane::MetaCache.get_config_data("knowledge_face_url")
  knowledge_face_url = "/uploads/paperclip/:class/:attachment/:id/:style/:filename"
  #    #knowledge_face_path = Askjane::MetaCache.get_config_data("knowledge_face_path")
  knowledge_face_path =":rails_root/public/uploads/paperclip/:class/:attachment/:id/:style/:filename"

  has_attached_file :face,:default_url => "/assets/face/:style/missing.png",
    :default_style => :s120,
    :styles => {
      :normal => "180x180#",
      :s120 => "120x120#",
      :s48 => "48x48#",
      :s32 => "32x32#",
      :s16 => "16x16#"
      },
    :url => knowledge_face_url,
    :path => knowledge_face_path

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

  #自身的model name
  self_model_name #引入 self_model_name
  #自身的model id
  self_model_id   #引入 self_model_id

  # 基础参数验证
  validates :title, :content, :created_by, :summary, :presence => true
  validates_uniqueness_of :title

  scope :by_join_date, :order => "created_at DESC"
  scope :not_deleted,  where("knowledgebase.deleted_at is NULL")
  scope :id_equals, lambda { |input_id| where("knowledgebase.id = ?", input_id)}

  define_index do
   indexes title
   indexes content
   where "deleted_at is null"
   #声明使用实时索引
   set_property :delta => true
  end

  # find the knowledges whose tags include param
  def self.find_knowledges_with_tag(tag_id)
    #Knowledge.find_by_sql("SELECT * FROM knowledges WHERE concat(',',concat(tags,',')) LIKE '%,"<<tag_id<<",%' ORDER BY created_at DESC")
    #search_field = ""
    #search_field = tag_id.to_s + " | ," + tag_id.to_s + " | ," + tag_id.to_s + ", | ," + tag_id.to_s
    #result=Knowledge.search(search_field, :match_mode => :any, :order => "created_at DESC")
    result = []
    result=ThinkingSphinx::Search.search("@tags "+tag_id.to_s, :class => [Knowledge],:match_mode  => :extended)
  end

  # return a sql string which can be excuted to get the knowledges list
  #def self.sql_find_knowledges_with_tag(tag_id)
  #  ("SELECT * FROM knowledges WHERE concat(',',concat(tags,',')) LIKE '%,"<<tag_id<<",%' ORDER BY created_at DESC")
  #end

  def if_soft_deleted(soft_deleted =nil, user = nil)
    if soft_deleted.present? and user.present?
      if ["true","1",1,true].include? soft_deleted
        self.deleted_at = Time.now
        self.deleted_by = user.id if user.id.present?
      else
        self.deleted_at = nil
        self.deleted_by = nil
      end
    end
  end

  def deleted_user
    User.find(self.deleted_by) if (self.deleted_by.present?) and (User.exists? self.deleted_by)
  end

  # 作者
  def owner
    knowledge.find_by_user_id(self.created_by)
  end

  def updated_user
     find_user self.updated_by if self.updated_by.present?
  end

  def created_user
     find_user self.created_by if self.created_by.present?
  end


  # previous knowledeg of the current knowledeg
  def previous_item
    self.class.first(:conditions => ["knowledgebase_category_id = ? and id < ? and deleted_at is null", self.knowledgebase_category_id, self.id], :order => "id DESC")
  end

  # next knowledeg of the current knowledeg
  def next_item
    self.class.first(:conditions => ["knowledgebase_category_id = ? and id > ? and deleted_at is null", self.knowledgebase_category_id, self.id], :order => "id ASC")
  end

    # 敏感词验证
  def check_spam_words
    self.spam?("title")
    self.spam?("content")
  end

  def repear_save
    self.content = Sanitize.clean(self.body).strip
    ##(/，|,|;|；|\ +|\||\r\n/)
    self.tag_list = sort_tag_list(self.tag_list) if self.tag_list.present?
    self.timeline_list = sort_tag_list(self.timeline_list) if self.timeline_list.present?
    self.category_list = sort_tag_list(self.category_list) if self.category_list.present?
    self.identity_list = sort_tag_list(self.identity_list) if self.identity_list..present?
  end

  def count_focus
    self.thanks_count.to_i
  end
  private
  def find_user(user_id = nil)
     (User.where :id => user_id ).first if user_id.present?
    #if user_id.present?
    #  u=User.where :id => user_id
    #  unless u.empty?
    #    u.first
    #  end
    #end
  end

  def sort_tag_list(tag_list= [])
    tag_str = ''
    tag_list.each do |tag|
      tag_str = tag_str+ ',' + tag
    end
    tag_str.to_s.split(/，|,|;|；|\ +|\||\r\n/) if tag_str.present?
  end

  class << self
    def find_recent(options = {})
      tag = options.delete(:tag)
      options = {
        :order      => 'knowledges.updated_at DESC',
        :conditions => ['updated_at < ?', Time.zone.now],
        :limit      => DEFAULT_LIMIT
      }.merge(options)
      if tag
        find_tagged_with(tag, options)
      else
        find(:all, options)
      end
    end
  end

end
