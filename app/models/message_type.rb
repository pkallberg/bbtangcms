# coding: utf-8
class MessageType < ActiveRecord::Base
  has_many :message_boxes
  
  def self.find_id_by_name(name)
    @message_type = MessageType.find_by_name(name)
    return nil if @message_type.blank?
    return @message_type.id 
  end
end
