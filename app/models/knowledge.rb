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
  has_many :profiles,:through => :r_user_knowledges 


  #缩略图
  has_attached_file :thumbnail,
    :default_style => :s120,
    :styles => {
      :normal => "75x75#",
      :s120 => "120x120#",
      :s48 => "48x48#",
      :s32 => "32x32#",
      :s16 => "16x16#"
      },
    :url => "/uploadfiles/:class/:attachment/:id/:basename/:style.:extension",
    :path => ":rails_root/public/uploadfiles/:class/:attachment/:id/:basename/:style.:extension"
     
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
  
=begin
  define_index do
   indexes title 
   indexes content
   indexes tags
   has :created_at
   where "deleted_at is null"
   #声明使用实时索引
   set_property :delta => true
  end
=end
  
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
  
  
  # 作者
  def owner
    Profile.find_by_user_id(self.created_by)
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
  end
  
  def count_focus
    self.thanks_count.to_i
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
