# coding: utf-8
class Answer < ActiveRecord::Base
  belongs_to :question

  validates :question_id, :presence => true
  validates :body, :presence => true#, :length => {:maximum => Askjane::MetaCache.get_config_data("answer_body_max").to_i}

  after_initialize :init

=begin
  define_index do
    indexes content
    # 删除的和草稿不索引
    where "deleted_at is null"
    #声明使用实时索引
    set_property :delta => true
  end
=end

  # 设置初始值
  def init
    self.opposition_count ||= 0
    self.approval_count ||= 0
    self.expert_count ||= 0
    self.no_help_count ||= 0
    self.thanks_count ||= 0
    self.is_anonymous ||= 0
  end

  def available_comments
    Comment.where(["model_object_id=? and object_target_id=? and deleted_at is null", 2,self.id])
  end

  # answer 的 owner
  def owner
    Profile.find_by_user_id(self.created_by)
  end


  def if_soft_deleted(user = nil)
    if self.soft_deleted.present? and user.present?
      if ["true","1",1,true].include? self.soft_deleted
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

end
