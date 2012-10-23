# coding: utf-8
=begin
EventLog.all.map(&:item_type).uniq
 => ["User", "Note", "Answer", "Question", "Knowledge"]
=end
class EventLog
  include Mongoid::Document
  #store_in collection: "citizens", database: "other", session: "secondary"
  store_in collection: "event_log", database: "bbtang_development"
  
  
  field :creat_by, type: Integer
  field :item_id, type: Integer
  field :item_type, type: String
  field :event, type: String
end
