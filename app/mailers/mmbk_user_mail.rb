# coding: utf-8
class MMBKUserMail < AsyncMailer
  CustomSetting = {
    :user_name => 'service@mamabkoo.com',
    :password => 'service1'
  }

  default :from => CustomSetting[:user_name],
               #:abcc => 'email_logger@test.lindsaar.net',
               :reply_to => CustomSetting[:user_name],
               :sender => CustomSetting[:user_name]



  BaseSetting = ActionMailer::Base.smtp_settings


  def self.smtp_settings
    @@smtp_settings = ActionMailer::Base.smtp_settings.merge CustomSetting
  end

  # MMBKUserMail.welcome_mmbkoo_user(user: 1435).deliver
  def welcome_mmbkoo_user(user = nil)

    @user = User.find user if user.present? and User.exists? user
    #@password = password
    if @user.present?
=begin
      if @password.empty?
        @password = Devise.friendly_token[0,10]
        @user.password = @password
        @user.save
      end
=end
      @email = @user.email

      mail(:to => @email,
           :subject => "育儿问题快速答——妈妈宝酷新服务！",
           :template_path => 'mailer',
           :template_name => 'welcome_mmbkoo_user')
    end
  end

  # 测试邮件
  def send_test_email(email ="864248765@qq.com")

    @email = email
    mail(:to => @email,
         :subject => "测试邮件",
         :template_path => 'mailer',
         :template_name => 'test_email')
  end

end
