# coding: utf-8
class Admin::IpSettingsController < ApplicationController
  layout "layouts/admin"
  respond_to :html, :js
  
  def index
    @setting_subject = SettingSubject.find_by_name("访问IP设置")
    @setting_type = @setting_subject.setting_type
  end
  
  def show
    redirect_to admin_ip_settings_path
  end
  
  def save
    ip_black_list = AdminSetting.find_by_name("ip_black_list")
    ip_white_list = AdminSetting.find_by_name("ip_white_list")
    
    ip_black_list.value = params[:ip_black_list].to_s
    ip_white_list.value = params[:ip_white_list].to_s
    
    if ip_black_list.save and ip_white_list.save
      # 写入到Rails设置
      Askjane::MetaCache.set_config_data("ip_black_list", ip_black_list.value)
      Askjane::MetaCache.set_config_data("ip_white_list", ip_white_list.value)
      respond_with
    end
  end
  
end
