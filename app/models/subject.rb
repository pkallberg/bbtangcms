class Subject < ActiveRecord::Base
  has_paper_trail   # you can pass various options here

  before_validation :repear_save

  attr_accessor :soft_deleted


  attr_accessible :title, :title2, :face, :summary, :body, :content,
                  :category, :created_by, :created_at, :updated_at, :updated_by,
                  :deleted_by_id, :deleted_at, :soft_deleted




  validates :title, :presence => true

  #knowledge_face_url = Askjane::MetaCache.get_config_data("knowledge_face_url")
  subject_face_url = "/uploads/paperclip/:class/:attachment/:id/:style/:filename"
  #    #knowledge_face_path = Askjane::MetaCache.get_config_data("knowledge_face_path")
  subject_face_path =":rails_root/public/uploads/paperclip/:class/:attachment/:id/:style/:filename"

  has_attached_file :face,:default_url => "/assets/face/:style/missing.png",
    :default_style => :s120,
    :styles => {
      :normal => "180x180#",
      :s120 => "120x120#",
      :s48 => "48x48#",
      :s32 => "32x32#",
      :s16 => "16x16#"
      },
    :url => subject_face_url,
    :path => subject_face_path


  def if_soft_deleted(soft_deleted =nil, user = nil)
    if soft_deleted.present? and user.present?
      if ["true","1",1,true].include? soft_deleted
        self.deleted_at = Time.now
        self.deleted_by_id = user.id if user.id.present?
      else
        self.deleted_at = nil
        self.deleted_by_id = nil
      end
    end
  end

  def created_user
    User.find(self.created_by) if (self.created_by.present?) and (User.exists? self.created_by)
  end

  def deleted_user
    User.find(self.deleted_by_id) if (self.deleted_by_id.present?) and (User.exists? deleted_by_id)
  end

  def updated_user
    User.find(self.deleted_by_id) if (self.deleted_by_id.present?) and (User.exists? deleted_by_id)
  end

  def repear_save
    self.content = Sanitize.clean(self.body).strip
  end

end
