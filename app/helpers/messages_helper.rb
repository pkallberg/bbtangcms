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
      "#{messages.count} new message from " + messages.map(&:from).collect{|u| "#{u}"}.compact.uniq.join(",")
    end
  end
end
