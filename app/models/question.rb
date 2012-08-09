# coding: utf-8
class Question < ActiveRecord::Base
  #acts_as_taggable
  has_paper_trail   # you can pass various options here

  acts_as_taggable_on :tags, :timelines, :categories, :identities
  acts_as_followable
  #include Redis::Search
  #include Recommendation::Search

  before_validation :repear_save
  before_save :update_tags_count

  attr_accessor :soft_deleted

    attr_accessible :title, :body, :created_by, :created_at,
                  :updated_at, :is_anonymous, :soft_deleted,
                  :score, :identity_list, :timeline_list,
                  :category_list, :tag_list


  self_model_name  #引入self_model_name
  self_model_id    #引入self_model_id

  has_many :answers
  validates :title, :presence => true
  #validates :title, :length => {:maximum => Askjane::MetaCache.get_config_data("question_title_max").to_i}
  validates :created_by, :presence => true
  #validates :body, :length => {:maximum => Askjane::MetaCache.get_config_data("question_body_max").to_i}

  #after_initialize :init


=begin
  redis_search_index(
    :title_field => :title,
    :prefix_index_enable => true,
    :score_field => :last_answer_time,
    :ext_fields => [:answers_count, :experts_count, :focus_by]
  )
=end

  def created_user
    User.find(self.created_by) if (self.created_by.present?) and (User.exists? self.created_by)
  end

  define_index do
    indexes title
    indexes content
    where "deleted is null"
    #声明使用实时索引
    set_property :delta => true
  end

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

  # 设置初始值
  def init
    self.views_count ||= 0
    self.tags ||= ""
    self.designated_answerer ||= nil
    if self.designated_answerer == 0
      self.designated_answerer = nil
    end
    self.answers_count ||= 0
    self.experts_count ||= 0
  end

  #自身的model name
  self_model_name #引入 self_model_name
  #自身的model id
  self_model_id   #引入 self_model_id

  def available_answers
    self.answers.where("deleted_at is null and state='sent'")
  end

  def available_comments
    Comment.where(["model_object_id=? and object_target_id=? and deleted_at is null", 1,self.id])
  end

  def available_answers_sort_time_desc
    self.available_answers.order("created_at desc")
  end

  def available_answers_sort_vote_desc
    self.available_answers.order("(approval_count-opposition_count) desc")
  end

  def saved_answer(user_id)
    self.answers.where(["deleted_at is null and state is not null and state<>'sent' and created_by=?",user_id])
  end

  def answered?(user_id)
    self.available_answers.each do |answer|
      if answer.created_by==user_id
        return true
      end
    end
    return false
  end

  # 返回相似问题
  #def similar_questions
  #  redis = Askjane::DefineRedis.define_recommendation_redis(Recommendation::Search.config.namespace,"similar_questions")
  #  s = redis.zrange self.id,0,-1
  #  ids = []
  #  s.each do |t|
  #    ids << t.to_i
  #  end
  #  return ids
  #end


  # the questions which belong to talents
  scope :questions_of_talents, {
                                :select => "questions.*",
                                :joins => "LEFT JOIN profiles ON questions.created_by = profiles.user_id INNER JOIN levels ON profiles.level_id = levels.id",
                                :conditions => "levels.id = 2",
                                :order => "created_at DESC"
                             }

  # the photos which belong to experts
  scope :questions_of_experts, {
                                :select => "questions.*",
                                :joins => "LEFT JOIN profiles ON questions.created_by = profiles.user_id INNER JOIN levels ON profiles.level_id = levels.id",
                                :conditions => "levels.id = 3",
                                :order => "created_at DESC"
                             }

  # question 的所有者
  def owner
    Profile.find_by_user_id(self.created_by)
  end

  def repear_save
    self.content = Sanitize.clean(self.body).strip
    ##(/，|,|;|；|\ +|\||\r\n/)
    self.tag_list = sort_tag_list(self.tag_list) if self.tag_list.present?
    self.timeline_list = sort_tag_list(self.timeline_list) if self.timeline_list.present?
    self.category_list = sort_tag_list(self.category_list) if self.category_list.present?
    self.identity_list = sort_tag_list(self.identity_list) if self.identity_list..present?
  end



  # 返回最佳答案
  def best_answer
    Answer.find_by_id(self.best_answer_id)
  end

  def expert_answers
    self.answers.where(is_expert: true)
  end

  def count_focus
    self.focus_by.to_s.split(",").count
  end

  # TODO:推送逻辑，考虑标签，浏览量，更新时间，其它？进行加权计算推荐优先度
  def recommend_knowledge
    recommend_knowledges.first
  end

  def recommend_knowledges
    #log=Logger.new("1.log")
    recommends = []

    Knowledge.where(id: recommends).order("updated_at desc").limit 4
  end

  def recommend_questions
    recommends = []

    Question.where(id: recommends).order("updated_at desc").limit 4
  end

  def update_tags_count
    tags_list = [:tags, :timelines, :categories, :identities]
    tags_list.each do |tag|
      tag = tag.to_s.singularize
      if self.respond_to?("#{tag}_list_changed?")
        #if self.send("#{tag}_list_changed?") == true
        t_list_changes = self.send("#{tag}_list_changes")
        if t_list_changes.present? and t_list_changes.count == 2
          if t_list_changes.first.class == String
            old_t = t_list_changes.first.split(',').collect {|t| t.gsub(' ',"")}    else
            old_t = t_list_changes.first
          end
          if t_list_changes.last.class == String
            new_t = t_list_changes.last.split(',').collect {|t| t.gsub(' ',"")}    else
            new_t = t_list_changes.last
          end
          set_tags_count(old_tags = old_t,new_tags = new_t)
        end
      end
    end
  end

  def set_tags_count(old_tags = [],new_tags = [],count_type=self.class.to_s.downcase.pluralize)

    #add count
    insert_tags = new_tags - old_tags
    if insert_tags.present?
      insert_tags.each do |t|
        if ActsAsTaggableOn::Tag.where(name: t).present?
          tag = ActsAsTaggableOn::Tag.where(name: t).first
          tag.send("#{count_type}_count=",tag.send("#{count_type}_count").to_i.next)
          tag.save
        end
      end
    end
    # pred  count
    pred_tags = old_tags - new_tags
    if pred_tags.present?
      pred_tags.each do |t|
        if ActsAsTaggableOn::Tag.where(name: t).present?
          tag = ActsAsTaggableOn::Tag.where(name: t).first
          tag.send("#{count_type}_count=",tag.send("#{count_type}_count").to_i.pred)
          tag.save
        end
      end
    end
  end

  def to_s
    self.title
  end
  private
  def sort_tag_list(tag_list= [])
    tag_str = ''
    tag_list.each do |tag|
      tag_str = tag_str+ ',' + tag
    end
    tag_str.to_s.split(/，|,|;|；|\ +|\||\r\n/) if tag_str.present?
  end

end
