class Attachment < ActiveRecord::Base
  before_validation :repear_save
  before_save :auto_add_description

  PURPOSE = {
    1        => "#{I18n.t('activerecord.attributes.attachment.p1')}",
    2     => "#{I18n.t('activerecord.attributes.attachment.p2')}",
    3     => "#{I18n.t('activerecord.attributes.attachment.p3')}",
    4     => "#{I18n.t('activerecord.attributes.attachment.p4')}",
    5     => "#{I18n.t('activerecord.attributes.attachment.p5')}",
    6     => "#{I18n.t('activerecord.attributes.attachment.p6')}",
    7     => "#{I18n.t('activerecord.attributes.attachment.p7')}",
    8     => "#{I18n.t('activerecord.attributes.attachment.p8')}",
    9     => "#{I18n.t('activerecord.attributes.attachment.p9')}",
    10     => "#{I18n.t('activerecord.attributes.attachment.p10')}",
  }

  attr_accessor :soft_deleted
  attr_accessible :attachment, :purpose, :note, :deleted_by_id,
                  :deleted_at, :created_by_id, :updated_by_id,
                  :created_at, :updated_at, :soft_deleted

  #knowledge_face_url = Askjane::MetaCache.get_config_data("knowledge_face_url")
  attachment_url = "/uploads/paperclip/:class/:attachment/:id/:style/:filename"
  #    #knowledge_face_path = Askjane::MetaCache.get_config_data("knowledge_face_path")
  attachment_path =":rails_root/public/uploads/paperclip/:class/:attachment/:id/:style/:filename"

  has_attached_file :attachment,:default_url => "/assets/face/:style/missing.png",
    :default_style => :s120,
    :styles => {
      :normal => "180x180#",
      :s120 => "120x120#",
      :s48 => "48x48#",
      :s32 => "32x32#",
      :s16 => "16x16#"
      },
    :url => attachment_url,
    :path => attachment_path

  #validates_attachment :attachment, :presence => true,
  validates_attachment :attachment,
                       :content_type => {:content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/bmp']}, :allow_nil=>true
                       #:size => { :in => 0..2.megabytes }

  #validates :attachment, :attachment_presence => true
  #validates_with AttachmentPresenceValidator, :attributes => :face
  validates_attachment_size :attachment, :less_than => 2.megabytes,
                          :unless => Proc.new {|m| m[:attachment].nil?}

  #before_post_process :image?
  #def image?
    #breakpoint
  #  !((self.attachment.content_type =~ /^image\/*/).nil?)
  #end





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
    User.find(self.created_by_id) if (self.created_by_id.present?) and (User.exists? self.created_by_id)
  end

  def deleted_user
    User.find(self.deleted_by_id) if (self.deleted_by_id.present?) and (User.exists? deleted_by_id)
  end

  def updated_user
    User.find(self.deleted_by_id) if (self.deleted_by_id.present?) and (User.exists? deleted_by_id)
  end

  # just a helper method for the view
  def purpose_name
    purpose_array = self.purpose.split(",")
    PURPOSE.collect { |p| p[1] if purpose_array.include? p[0].to_s}.compact.uniq.join(",")
  end

  def repear_save
    #(self.purpose.join ",").split(",")
    self.purpose = self.purpose.join ","
  end

  private
  def auto_add_description
     self.note = "description for attachment #{self.id}" unless self.note.present?
  end
end
