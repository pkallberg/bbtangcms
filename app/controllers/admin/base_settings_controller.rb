# coding: utf-8
class Admin::BaseSettingsController < Admin::AdminBaseController
  authorize_resource :class => false
  #layout "layouts/admin"
  respond_to :html, :js

  def index
    @setting_subject = SettingSubject[controller_name]
    @setting_type = controller_name
  end

  # 基本设置 保存
  def save
    @options = ["statistics", "site_close", "site_close_info",
                "focus_group_size", "email_notification_days"]
    params.each do |param|
      if @options.include? param[0].to_s
        setting = AdminSetting.find_by_name(param[0].to_s)
        setting.value = param[1].to_s
        setting.save

        # 写入到Rails设置
        BBTangCMS::MetaCache.set_config_data(setting.name, setting.value)
      end
    end

    respond_with @options
  end

  # 增加举报原因
  def add_report_reason
    value = params[:value].to_s
    if value == ""
      render :text => "不能为空！" and return
    end
    settings = AdminSetting.find_all_by_name("report_reason")
    settings.each do |setting|
      if value == setting.value
        render :text => "已存在！" and return
      end
    end
    setting = AdminSetting.new(:name => "report_reason", :value => value, :type_name => "report_reason")
    if setting.save
      # 写入到Rails设置
      BBTangCMS::MetaCache.set_type_name_config_data("report_reason", setting.id, setting.value)
      render :text => "ok" and return
    end
    render :text => "保存失败！" and return
  end

  # 删除举报原因
  def delete_report_reason
    values = params[:values]
    values.each do |value|
      if value == ""
        render :text => "不能为空！" and return
      end
      if setting =AdminSetting.where(["name = 'report_reason' and value = ?", value]).first
        # 写入到Rails设置
        BBTangCMS::MetaCache.delete_type_name_config_data("report_reason", setting.id)
        setting.delete
      else
        render :text => "不存在！" and return
      end
    end
    render :text => "ok" and return
  end

end
