# coding: utf-8
class MessagesController < ApplicationController
  #skip_authorization_check

  Model_class = Message.new.class
  def index
    @messagebox = params[:messagebox].blank? ? "inbox" : params[:messagebox]

    @messages = current_user.send(@messagebox).group(:subject_id).paginate(:page => params[:page])
    case @messagebox
    when "trash"
      @options = ["Read","Unread","Delete","Undelete"].collect{ |p| [I18n.t("helpers.options.#{p.downcase}"),p]}
    else
      @options = ["Read","Unread","Delete"].collect{ |p| [I18n.t("helpers.options.#{p.downcase}"),p]}
    end
  end

  def show
    unless params[:messagebox].blank?
      message = current_user.send(params[:messagebox]).find(params[:id])

      @messages = message.root.subtree
      @parent_id = @messages.last.id

      if @messages.last.copies
        @user_tokens = @messages.last.recipient_id
        @parent_id = @messages.last.ancestor_ids.last unless @parent_id.nil?
      else
        @user_tokens = @messages.last.sender_id
      end

      read_unread_messages(true, *@messages)
      breadcrumbs.add I18n.t("helpers.titles.read", :model => Model_class.model_name.human), new_news_path
    end
  end

  def new
    @message = Message.new
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_news_path
  end

  def create
    unless params[:user_tokens].blank? or params[:subject].blank? or params[:content].blank?
      #recipients = User.find(params[:message][:user].split(",").collect { |id| id.to_i })
      recipients = find_user(word = params[:user_tokens])

      if current_user.send_message?(:recipients => recipients, :subject_id => params[:subject_id], :subject => params[:subject], :content => params[:content], :parent_id => params[:parent_id])
          redirect_to box_messages_url(:inbox), :notice => 'Successfully send message.'
        else
          flash.now[:alert] = "Unable to send message."
          render "new"
        end
      else
      flash.now[:alert] = "Invalid input for sending message."
      render "new"
    end
  end

  def update
    unless params[:messages].nil?
      message = current_user.send(params[:messagebox]).find(params[:messages])

      message.each do |message|
        messages = message.root.subtree
        if params[:option].downcase == "read"
          read_unread_messages(true,*messages)
        elsif params[:option].downcase == "unread"
          read_unread_messages(false,*messages)
        elsif params[:option].downcase == "delete"
          delete_messages(true,*messages)
        elsif params[:option].downcase == "undelete"
          delete_messages(false,*messages)
        end
      end
    end
    redirect_to box_messages_url(params[:messagebox])
  end

  def empty
   unless params[:messagebox].nil?
      current_user.empty_messages(params[:messagebox].to_sym => true)
      redirect_to box_messages_url(params[:messagebox]), :notice => "Successfully delete all messages."
   end
  end

  def token
    query = "%" + params[:q] + "%"
    recipients = User.select("id,email").where("email like ?", query)
    respond_to do |format|
      format.json { render :json => recipients.map { |u| { "id" => u.id, "name" => u.email} } }
    end
  end

private

  def read_unread_messages(isRead, *messages)
    messages.each do |msg|
      unless msg.copies
        if isRead
          msg.mark_as_read unless msg.read?
        else
          msg.mark_as_unread if msg.read?
        end
      end
    end
  end

  def delete_messages(isDelete, *messages)
    messages.each do |msg|
      if isDelete
        msg.delete
      else
        msg.undelete
      end
    end
  end

  def find_user(word = "")
    word = word.split(/，|,|;|；|\ +|\||\r\n/)
    cms_roles = CmsRole.all
    users = []
    #users = word.collect { |id| User.find id.to_i if User.exists? id.to_i }.compact.uniq

    word.each do |w|
      #users.concat CmsRole.find_by_name(2).users if cms_roles.map(&:name).include? w
      cms_roles.collect {|c| users.concat c.users if c.name.eql? w}
      users.append User.find w.to_i if User.exists? w.to_i
      users.append User.find_by_email w if User.exists? email: w
      users.append User.find_by_username w if User.exists? username: w
    end
    return users.compact.uniq
  end

  def cms_role_users
  end

end
