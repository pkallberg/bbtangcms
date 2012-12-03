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

  face_url = "/uploads/paperclip/:class/:face/:id/:style/:filename"
  face_path =":rails_root/public/uploads/paperclip/:class/:face/:id/:style/:filename"

  has_attached_file :face,:default_url => "/assets/face/:style/missing.png",
    :default_style => :s120,
    :styles => {
      :normal => "180x180#",
      :s120 => "120x120#",
      :s48 => "48x48#",
      :s32 => "32x32#",
      :s16 => "16x16#"
      },
    :url => face_url,
    :path => face_path
    
  validates_attachment :face,
                       :content_type => {:content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/bmp']}, :allow_nil=>true

  validates_attachment_size :face, :less_than => 2.megabytes,
                          :unless => Proc.new {|m| m[:face].nil?}

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
  #self.created_by 实际上是 user_id
  def owner
    Profile.find_by_user_id(self.created_by)
  end

  def created_by_id
    self.created_by
  end

  #def updated_user
  #  find_user self.updated_by if self.updated_by.present?
  #end

  def created_user
    find_user self.created_by if self.created_by.present?
  end

  def note_next
    note =Note.where(["id > ? and created_by = ?" ,self.id.to_i,self.created_by]).order("created_at").limit(1).first
  end

  def note_last
    note = Note.where(["id < ? and created_by = ?"  ,self.id.to_i,self.created_by]).order("created_at desc").limit(1).first

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
