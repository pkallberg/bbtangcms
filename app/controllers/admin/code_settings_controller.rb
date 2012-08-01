# coding: utf-8
class Admin::CodeSettingsController < Admin::AdminBaseController
  #layout "layouts/admin"
  respond_to :html, :js

  def index
    @setting_subject = SettingSubject.find_by_name("代码参数设置")
    @setting_type = @setting_subject.setting_type
  end

  def show
    redirect_to admin_code_settings_path
  end

  def edit
    @code = AdminSetting.find(params[:id])
    @setting_type = SettingType.find(params[:setting_type_id])
    @setting_subject = SettingSubject.find(params[:setting_subject_id])
  end

  def update
    @setting_type = SettingType.find(params[:setting_type_id])
    @setting_subject = SettingSubject.find(params[:setting_subject_id])
    code = AdminSetting.find(params[:id])
    code.name = params[:code_name]
    code.value = params[:code_value]
    code.description = params[:code_description]
    if code.save
      # 写入rails配置
      BBTangCMS::MetaCache.set_config_data(code.name, code.value)
      redirect_to admin_code_settings_path
    else
      render :edit
    end
  end

end
