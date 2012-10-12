# encoding: utf-8
module MessagesHelper
  def new_messages(user = nil)
    user ||= current_user
    new_messages = user.inbox(:opened => false)
    if new_messages.present?
      new_messages
    else
      nil
    end
  end
  def new_messages_notice(user = nil)
    messages = new_messages(user = user)
    if messages.present?
      "你有来自于" << messages.map(&:from).collect{|u| "#{u}"}.compact.uniq.join(",") << "的#{messages.count}条消息"
    end
  end
end
