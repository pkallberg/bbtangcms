class KnowledgebaseCategory < ActiveRecord::Base
  has_many :knowledges, :order => "created_at DESC", :conditions => {:deleted_at => nil}
  
  # 知识分类的缩略图
  has_attached_file :thumbnail,
    :default_style => :s120,
    :styles => {
      :normal => "180x180#",
      :s120 => "120x120#",
      :s48 => "48x48#",
      :s32 => "32x32#",
      :s16 => "16x16#"
      },
    :url => "/uploadfiles/:class/:attachment/:id/:basename/:style.:extension",
    :path => ":rails_root/public/uploadfiles/:class/:attachment/:id/:basename/:style.:extension"  
end
