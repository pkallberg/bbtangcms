# coding: utf-8
class UserMail < ActionMailer::Base
  include Resque::Mailer

  default :from => BBTangCMS::MetaCache.get_config_data("email_account")

  def send_reuse(email,token)

  end

  # 发送邀请邮件
  def send_invitation(list, url)
    return false if list.empty?
    list.each do |index, email|
      @email = email
      @name = I18n.t("site_name")
      @url = url
      @user_url = url

      # email = email
      # name = I18n.t("site_name")
      # url = url
      mail(:to => email,
           :subject => t("invitation_subject"),
           :template_path => 'mailer',
           :template_name => 'question_invite')
      mail.deliver
    end
    return true
  end

  # 分享问题
  def send_question_shared(email, display_name, url, user_url)
    @email = email
    @name = display_name
    @url = url
    @user_url = user_url
    mail(:to => @email,
         :subject => "分享问题",
         :template_path => 'mailer',
         :template_name => 'question_shared')
  end

  # 邀请回答
  def send_question_invite(email, display_name, url, user_url)
    @email = email
    @name = display_name
    @url = url
    @user_url = user_url
    mail(:to => @email,
         :subject => "邀请回答问题",
         :template_path => 'mailer',
         :template_name => 'question_invite')
  end

  # 分享问题
  #email = "305912847@qq.com"
  def send_new_question_notify(email = "305912847@qq.com", question_id  = Question.last.id)
    @question = Question.find_by_id question_id
    @email = email

    mail(:to => @email,
         :subject => "hi #{@email}, 新问题提示 #{@question.title}！",
         :template_path => 'mailer',
         :template_name => 'new_question_notify')
  end

  # 测试邮件
  def send_test_email(email)
    @email = email
    mail(:to => @email,
         :subject => "测试邮件",
         :template_path => 'mailer',
         :template_name => 'test_email')
  end
end
