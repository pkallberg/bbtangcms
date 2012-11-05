# coding: utf-8
class Admin::EmailSettingsController < Admin::AdminBaseController
  authorize_resource :class => false
  #layout "layouts/admin"
  respond_to :html, :js

  def index
    @setting_subject = SettingSubject.find_by_name("邮件设置")
    @setting_type = @setting_subject.setting_type
  end

  def save
    @options = ["smtp_email_host", "email_host", "email_port", "email_account", "email_password", "email_reply_address"]
    params.each do |param|
      if @options.include? param[0].to_s
        setting = AdminSetting.find_by_name(param[0].to_s)
        setting.value = param[1].to_s
        setting.save
      end
    end
    change_email_settings
    respond_with
  end

  # 发送测试邮件
  def send_test_email
    email = params[:email]
    smtp = params[:smtp]
    host = params[:host]
    port = params[:port]
    account = params[:account]
    password = params[:password]

    # 暂时改变邮件设置
    ActionMailer::Base.smtp_settings = {
      :address=> smtp.to_s,
      :port=> port.to_i,
      :domain=> host.to_s,
      :user_name=> account.to_s,
      :password=> password.to_s,
      :authentication=>"login"
    }

    ActionMailer::Base.default :from => account.to_s

    mail = UserMail.send_test_email(email)
    begin
      mail.deliver!
    rescue
      # 还原邮件设置
      change_email_settings
      render "none" and return
    end
    # 还原邮件设置
    change_email_settings
    render :text => "ok" and return
  end

  # 修改系统邮件设置
  def change_email_settings
    ActionMailer::Base.smtp_settings = {
      :address=> AdminSetting.find_by_name("smtp_email_host").value.to_s,
      :port=> AdminSetting.find_by_name("email_port").value.to_i,
      :domain=> AdminSetting.find_by_name("email_host").value.to_s,
      :user_name=> AdminSetting.find_by_name("email_account").value.to_s,
      :password=> AdminSetting.find_by_name("email_password").value.to_s,
      :authentication=>"login"
    }
    ActionMailer::Base.default :from => AdminSetting.find_by_name("email_account").value.to_s
  end

end
