# coding: utf-8
class Admin::IpSettingsController < Admin::AdminBaseController
  authorize_resource :class => false
  #layout "layouts/admin"
  respond_to :html, :js

  def index
    @setting_subject = SettingSubject[controller_name]
    @setting_type = controller_name
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
      BBTangCMS::MetaCache.set_config_data("ip_black_list", ip_black_list.value)
      BBTangCMS::MetaCache.set_config_data("ip_white_list", ip_white_list.value)
      respond_with
    end
  end

end
