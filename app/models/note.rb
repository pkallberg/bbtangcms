# coding: utf-8
class Note < ActiveRecord::Base
  acts_as_followable
  acts_as_taggable_on :tags
  before_validation :repear_save

  has_paper_trail   # you can pass various options here
  after_save :clear_event_log
  after_destroy :clear_event_log

  validates :title, :length => {
    :minimum => 2,
    }

  def clear_event_log
    #Eventlog.remove("item_id" => params[:id].to_i, "item_type"=>"Note")
    if (self.respond_to? :deleted_by and self.send(:deleted_by)) or not(self.class.exists? self.id)
      EventLog.where(item_type: self.class.to_s,item_id: id).collect{|event_log| event_log.destroy} if self.present?
    end
  end

  def to_s
    self.title if self.title.present?
  end

  def comments_counts
    comments_count = Comment.where(["object_target_id = ? and model_object_id =14 and deleted_at is null",self.id ] ).count
  end

  # 作者
  #self.profile_id 实际上是 user_id
  def owner
    Profile.find_by_user_id(self.profile_id)
  end

  def created_by
    self.profile_id
  end

  def created_by_id
    self.profile_id
  end

  #def updated_user
  #  find_user self.updated_by if self.updated_by.present?
  #end

  def created_user
    find_user self.created_by if self.created_by.present?
  end

  def note_next
    note =Note.where(["id > ? and profile_id = ?" ,self.id.to_i,self.profile_id]).order("created_at").limit(1).first
  end

  def note_last
    note = Note.where(["id < ? and profile_id = ?"  ,self.id.to_i,self.profile_id]).order("created_at desc").limit(1).first

  end

  def repear_save
    self.content = Sanitize.clean(self.body).strip
    ##(/，|,|;|；|\ +|\||\r\n/)
    self.tag_list = sort_tag_list(self.tag_list) if self.tag_list.present?
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
end
