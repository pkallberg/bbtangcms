# coding: utf-8
class UserMail < AsyncMailer

  #default :from => BBTangCMS::MetaCache.get_config_data("email_account"),
  #       :return_path => BBTangCMS::MetaCache.get_config_data("email_reply_address")

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

  # 新问题提示
  #email = "305912847@qq.com"
  def send_new_question_notify(email = "305912847@qq.com", question_id  = Question.last.id)
    @question = Question.find_by_id question_id
    @email = email

    mail(:to => @email,
         :subject => "hi #{@email}, 新问题提示 #{@question.title}！",
         :template_path => 'mailer',
         :template_name => 'new_question_notify')
  end

  # 每周精选
  def weekly_notify(user = User.last)
    @user = User.find user if User.exists? user

    if @user.present?
      @email = @user.email

      mail(:to => @email,
           :subject => "你好 #{@user}, 每周精选！",
           :template_path => 'mailer',
           :template_name => 'weekly_notify')
    end
  end

  # 每月精选
  def monthly_notify(user = User.last)
    @user = User.find user if User.exists? user

    if @user.present?
      @email = @user.email

      mail(:to => @email,
           :subject => "你好 #{@user}, 每月精选！",
           :template_path => 'mailer',
           :template_name => 'monthly_notify')
    end
  end

  # 节日
  def festival_notify(user = User.last,festival = nil)
    @user = User.find user if User.exists? user
    @festival ||= "节日快乐"

    if @user.present?
      @email = @user.email

      mail(:to => @email,
           :subject => "你好 #{@user}, #{@festival}！",
           :template_path => 'mailer',
           :template_name => 'festival_notify')
    end

  end

  # user 生日
  def user_birthday_notify(profile = nil,pre_days = 0)
    @profile = Profile.find profile if Profile.exists? profile
    if @profile.present? and @profile.user.present?
      @user = @profile.user
      @email = @profile.user.email
      @pre_days = pre_days.present? ? pre_days : 0
      @pre_days_tips = (@pre_days > 0) ? "#{pre_days}天之后" : "今天"

      mail(:to => @email,
           :subject => "你好#{@user},#{@pre_days_tips}是你的#{@profile.age}岁生日,祝你生日快乐！",
           :template_path => 'mailer',
           :template_name => 'user_birthday_notify')
    end
  end

  # baby 生日
  def baby_birthday_notify(baby = nil,pre_days = 0)
    @baby = Baby.find baby if Baby.exists? baby
    @profile = @baby.profile
    if @baby.present? and @profile.present? and @profile.user.present?
      @user = @profile.user
      @email = @profile.user.email
      @pre_days = pre_days.present? ? pre_days : 0
      @pre_days_tips = (@pre_days > 0) ? "#{pre_days}天之后" : "今天"
      debugger
      mail(:to => @email,
           :subject => "你好 #{@user}, #{@pre_days_tips} 是你的孩子#{@baby},#{@baby.age} 岁生日,生日快乐！",
           :template_path => 'mailer',
           :template_name => 'baby_birthday_notify')
    end
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
