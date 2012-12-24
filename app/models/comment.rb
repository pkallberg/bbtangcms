# coding: utf-8
class Comment < ActiveRecord::Base
  has_paper_trail   # you can pass various options here
  before_validation :set_content  #填充content
  #acts_as_paranoid  #标记删除（deleted_at）
  after_save :clear_event_log_and_notify
  after_destroy :clear_event_log_and_notify
  
  validates :object_target_id, :model_object_id,:created_by, :presence => true
  validates :body, :presence => true #remove content by ivan, 此处不许要验证content为空，因为可以单独插入表情或者图片作为comment，这个时候content是没有内容的
  validates :body, :length => {:maximum => BBTangCMS::MetaCache.get_config_data("comment_content_limit").to_i}#, :unless => :is_kindeditor?

  scope :comments_of_knowledge, lambda{ where("comments.model_object_id = ? and comments.deleted_at is null", 3)}
  scope :comments_of_topic, lambda{where("comments.model_object_id = ? and comments.deleted_at is null", 4)}

  before_save :calculate_comments_count #在保存前统计更新所属对象的commets的总数

  #自身的model name  self_model_name #引入
  self_model_name
  #自身的model id
  self_model_id   #引入 self_model_id

  #通过model_object_id这个字段返回对应的目标model的对象
  def find_model_by_string
    @model =  BBTangCMS::MetaCache.get_data_by_id("model_objects",self.model_object_id)
    @model.camelize.constantize.find_by_id(self.object_target_id)
  end

  #判断该comment是否被其他会员like
  def has_like(user_id)
    if !self.like_by.blank? && !user_id.blank?
      ("["+self.like_by+"]").include?(user_id.to_s)
    else
      false
    end
  end

  #返回添加了会员id的like字段
  def add_like(user_id)
    if Comment.find_by_id(self.id).like_by.blank?
      user_id.to_s
    else
      Comment.find_by_id(self.id).like_by << "," << user_id.to_s
    end
  end
  #返回删除了会员id的like字段
  def remove_like(user_id)
    @like_by = Comment.find_by_id(self.id).like_by_to_array
    @like_by.delete(user_id)
    @like_by.to_s.delete('[').delete(']')
  end
  #将like_by转换成数组
  def like_by_to_array
    self.like_by.split(",").map {|a| a.to_i}
  end

  def owner
    Profile.find_by_user_id(self.created_by)
  end

  def clear_event_log_and_notify
    #Eventlog.remove("item_id" => params[:id].to_i, "item_type"=>"Note")
    if (self.respond_to? :deleted_by and self.send(:deleted_by)) or not(self.class.exists? self.id)
      #EventLog.where(item_type: self.class.to_s,item_id: id).collect{|event_log| event_log.destroy} if self.present?
      #Eventlog.remove("item_id" => self.id , "item_type"=>"Answer")
      #Eventlog.remove("item_id" => self.id , "item_type"=>"Question")
      Notify.remove("item_id" => self.id , "item_type"=>self.model_object.name) if self.model_object.present?
    end
  end

  private
  # 计算该topic下的comments的数目
    def calculate_comments_count
      case self.model_object_id # 判断当前comment属于哪个model
      when 4  # topic
        topic = Topic.find_by_id(self.object_target_id)
        # 每次当topic 的 comment执行save时，  更新comments总数
        topic.comments_count = Comment.where(:model_object_id=> 4,
                                            :object_target_id=>topic.id,
                                            :deleted_at => nil).count
        topic.save
      end
    end

    # TODO：need test！！！ 当提交保存的comment是 富文本编辑框 的内容， 跳过字长验证
    def is_kindeditor?
      # TODO: get the data from cache
      return true if self.model_object_id == 4
      return true if self.model_object_id == 3
      return false
    end


      #清除body里面的html标签
    def set_content
      self.content = Sanitize.clean(self.body)
    end
end
