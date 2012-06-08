# coding: utf-8
class Album < ActiveRecord::Base
  has_many :photos
  
  validates :title, :created_by, :presence => true
  
  
  after_initialize :init
  
  # 设置初始值
  def init
    self.views_count ||= 0
  end
  
  def available_photos 
    Photo.where(["album_id = ? and deleted_at is null", self.id])
  end
  
  def photo_numbers
    self.available_photos.size
  end
  
  def available_comments
    Comment.where(["model_object_id = ? and object_target_id = ? and deleted_at is null", 9, self.id])
  end
  
end
