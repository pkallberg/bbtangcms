# coding: utf-8
class Admin::SeoSettingsController < Admin::AdminBaseController
  #layout "layouts/admin"
  respond_to :html, :js

  def index
    @setting_subject = SettingSubject.find_by_name("SEO设置")
    @setting_type = @setting_subject.setting_type
  end

  def show
    redirect_to admin_seo_settings_path
  end

  def new
    @setting_subject = SettingSubject.find_by_name("SEO设置")
    @setting_type = @setting_subject.setting_type
  end

  def create
    @setting_type = SettingType.find(params[:setting_type_id])
    @setting_subject = SettingSubject.find(params[:setting_subject_id])
    value = {}
    value["title"] = params["seo_title"]
    value["keywords"] = params["seo_keywords"]
    value["description"] = params["seo_description"]
    value = value.to_json

    seo = AdminSetting.new(:name => params["seo_name"], :value => value, :type_name => "seo")

    if seo.save
      # 写入rails配置
      BBTangCMS::MetaCache.set_type_name_config_data("seo", seo.name, seo.value)
      redirect_to admin_seo_settings_path
    else
      render :new
    end
  end

  def edit
    @seo = AdminSetting.find(params[:id])
    @value = JSON.parse(@seo.value)
    @setting_type = SettingType.find(params[:setting_type_id])
    @setting_subject = SettingSubject.find(params[:setting_subject_id])
  end

  def update
    @setting_type = SettingType.find(params[:setting_type_id])
    @setting_subject = SettingSubject.find(params[:setting_subject_id])
    seo = AdminSetting.find(params[:id])
    value = JSON.parse(seo.value)
    value["title"] = params["seo_title"]
    value["keywords"] = params["seo_keywords"]
    value["description"] = params["seo_description"]
    value = value.to_json
    seo.name = params[:seo_name]
    seo.value = value
    if seo.save
      # 写入rails配置
      BBTangCMS::MetaCache.set_type_name_config_data("seo", seo.name, seo.value)
      redirect_to admin_seo_settings_path
    else
      render :edit
    end
  end

  def destroy
    @seo = AdminSetting.find(params[:id])
    # 写入到Rails设置
    BBTangCMS::MetaCache.delete_type_name_config_data("seo", @seo.name)
    @seo.delete
    respond_with
  end
end
