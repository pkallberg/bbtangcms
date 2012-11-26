# coding: utf-8
=begin
event:
  new_follow: "新粉丝"
  new_message_box: "新私信"
  new_answer: "新回答"
  new_designated_answerer: "新邀请回答"
  new_comment_user: "新留言"
  new_comment_photo: "评论相册"
  new_comment_note: "评论日志"
  new_comment_knowledge: "评论知识"
  #new_comment_question: "评论问题"
  new_comment_post: "评论贴子"
notify = {}
notify[:item_id]=@note.id
notify[:item_type]='Note'
notify[:create_user_id] = message_box[sender_id]
notify[:event]='新站内信'
notify[:relate_user_id]=message_box[recipient_id]
notify[:read]= true || false
notify[:content]=@note.title.to_s
notify[:content_path] = Time.now
notify[:created_at] = Time.now
notify[:updated_at] = Time.now
Notify.insert eventlog
#item is obj instance or item_id, item_type
notify = {:item => "",
          :item_id => "",
          :item_type => "",
          :create_user_id => "",
          :relate_user_id = > ""
          :event => "",
          :content => "",
          :content_path => ""
          }
u= User.find_by_email "864248765@qq.com"
m = u.message_boxes_inbox.where(:opened => false).last
notify = {:item => m, :create_user_id => m.sender_id, :relate_user_id => m.recipient_id, :event =>"New Message", :content => "New Message from #{m.from}!", :content_path => "/" }
Notify.create(notify)# return last item or false
=end
Notify = BBTDB.collection "notifies"

def Notify.create(notify = {})
  if notify.has_key? :item and notify[:item].present?
    item = notify.delete(:item)
    notify[:item_id] = item.id
    notify[:item_type] = item.class.to_s
  end
  notify[:relate_user_id] = notify[:relate_user_id].to_i if notify[:relate_user_id].present? and (notify[:relate_user_id].to_i > 0 )
  required_columns = [:item_id,:item_type, :event, :content]
  if (notify.keys & required_columns).sort.eql? required_columns.sort
    Notify.insert notify.merge({read: false, updated_at: Time.now, created_at: Time.now})
    utc_to_local Notify.find_one
  else
    false
  end
end

def Notify.hello
  puts "hello mogo!"
end
#{ _id: BSON::ObjectId( "505971c508a56411d7000001" ) }
#Notify.update({ _id: BSON::ObjectId( "505971c508a56411d7000001" ) },{:read => false})
def Notify.find_by_id(id="")
  if id.present?
    notify = Notify.find({_id: BSON::ObjectId(id)}).first
    utc_to_local(notify)
  end
end

#Notify.update({_id: BSON::ObjectId("alksjdfklaksdljf")},{xxxx})
def Notify.update_by_id(id="",conditions={})
  if id.present?
    Notify.update({_id: BSON::ObjectId(id)},'$set' => conditions.merge({updated_at: Time.now}))
  end
end

def Notify.read(id="")
  Notify.update_by_id(id = id,{read: true})
end

def Notify.read?(id="")
  notify = Notify.find({_id: BSON::ObjectId(id)}).first
  true if notify.has_keys? :read and notify[:read].eql? true
end

def Notify.user_notifies(user_id = "")
  notifies = Notify.find({relate_user_id: user_id.to_i}).to_a.collect{|notify| utc_to_local(notify)}
end
#Notify.user_notifies_by_event user_id = 1435 ,event = "new_answer"
def Notify.user_notifies_by_event(user_id = "",event = "")
  if user_id.present? and event.present?
    notifies = Notify.find({relate_user_id: user_id.to_i}.merge(event: event)).to_a.collect{|notify| utc_to_local(notify)}.reverse
  end
end

def Notify.user_notifies_by_event_read_all(user_id = "",event = "")
  if user_id.present? and event.present?
    notifies = Notify.find({relate_user_id: user_id.to_i}.merge(event: event)).to_a.collect{|notify| utc_to_local(notify)}
    notifies.each do |n|
      Notify.read(n["_id"].to_s)
    end
  end
end

def Notify.user_new_notifies_by_event(user_id = "",event = "")
  if user_id.present? and event.present?
    notifies = Notify.find({relate_user_id: user_id.to_i}.merge(event: event).merge(read: false)).to_a.collect{|notify| utc_to_local(notify)}
  end
end


#Notify.user_notifies_by_type user_id = 1435 ,event = "new_discuss"
def Notify.user_notifies_by_type(user_id = "",type = "")
  if user_id.present? and type.present?
    type = (type.eql? "new_discuss") ? %w(new_comment_photo new_comment_note new_comment_post) : [type]#not %w("#{type}")
    notifies = []
    type.collect{|event| notifies.concat Notify.find({relate_user_id: user_id.to_i}.merge(event: event)).to_a}
    notifies.compact.collect{|notify| utc_to_local(notify)}
  end
end

def Notify.user_notifies_by_type_read_all(user_id = "",type = "")
  if user_id.present? and type.present?
    type = (type.eql? "new_discuss") ? %w(new_comment_photo new_comment_note new_comment_post) :  [type]# not %w("#{type}")
    notifies = []
    type.collect{|event| notifies.concat Notify.find({relate_user_id: user_id.to_i}.merge(event: event)).to_a}
    notifies.each do |n|
      Notify.read(n["_id"].to_s)
    end
    notifies.compact.collect{|notify| utc_to_local(notify)}
  end
end

def Notify.user_new_notifies_by_type(user_id = "",type = "")
  if user_id.present? and type.present?
    type = (type.eql? "new_discuss") ? %w(new_comment_photo new_comment_note new_comment_post) :  [type]# not %w("#{type}")
    notifies = []
    type.collect{|event| notifies.concat Notify.find({relate_user_id: user_id.to_i}.merge(event: event).merge(read: false)).to_a}
    notifies.compact.collect{|notify| utc_to_local(notify)}
  end
end

def Notify.user_new_notifies(user_id="")
  notify = Notify.find({relate_user_id: user_id.to_i,read: false}).to_a
end

def Notify.unread(id="")
  Notify.update_by_id(id = id,{read: false})
end

def Notify.destroy(id = "")
  Notify.remove({_id: BSON::ObjectId(id)})
end

def find_user(id="")
  User.find id if User.exists? id
end

def Notify.create_user(id = "")
  notify = Notify.find_by_id(id)
  find_user(notify["create_user_id"]) if notify.present?
end

def Notify.relate_user(id = "")
  notify = Notify.find_by_id(id)
  find_user(notify["relate_user_id"]) if notify.present?
end

def Notify.item(id = "")
  notify = Notify.find_by_id(id)
  if notify["item_type"].class_exists?
    notify["item_type"].constantize.find_by_id notify["item_id"]
  end
end

def utc_to_local(notify = nil)
  if notify.present?
    update_at = notify["updated_at"]
    notify["updated_at"] = (update_at.class.eql? Time) ? update_at.localtime : update_at
    created_at = notify["created_at"]
    notify["created_at"] = (created_at.class.eql? Time) ? created_at.localtime : created_at
    notify
  end
end
