# coding: utf-8
class Admin::LinksSettingsController < Admin::AdminBaseController
  authorize_resource :class => false
  #layout "layouts/admin"
  respond_to :html, :js

  def index
    @setting_subject = SettingSubject.find_by_name("友情链接")
    @setting_type = @setting_subject.setting_type
  end

  def new_link
    @setting_subject = SettingSubject.find_by_name("友情链接")
    @setting_type = @setting_subject.setting_type
    @value = {}
  end

  def create_link
    @setting_type = SettingType.find(params[:setting_type_id])
    @setting_subject = SettingSubject.find(params[:setting_subject_id])
    @value = {}
    @value["name"] = params["link_name"]
    @value["href"] = params["link_href"]
    @value["sequence"] = params["link_sequence"]
    if params["link_logo_file"]
      file = params["link_logo_file"]
      sanitize_filename(file.original_filename) #过滤文件名
      if not ["image/jpg", "image/jpeg", "image/png", "image/gif"].include? file.content_type.chomp.downcase
        render :new_link and return
      end
      if file.original_filename
        filename = Time.now.strftime("%Y%m%d%H%M%S") + file.original_filename
        File.open("#{Rails.root}/public/uploads/links/#{filename}", "wb") do |f|
          f.write(file.read)
        end
        @value["logo"] = "/uploads/links/" + filename
      else
        render :new_link and return
      end
    else
      @value["logo"] = params["link_logo"]
    end
    @link = AdminSetting.new(:name => "link", :value => @value.to_json)
    if @link.save
      # 写入到Rails设置
      BBTangCMS::MetaCache.set_type_name_config_data("link", @link.id, @link.value)
      redirect_to "/admin/links_settings"
    else
      render :new_link and return
    end
  end

  def edit_link
    @link = AdminSetting.find(params[:link_id])
    @value = JSON.parse(@link.value)
    @setting_type = SettingType.find(params[:setting_type_id])
    @setting_subject = SettingSubject.find(params[:setting_subject_id])
  end

  def update_link
    @setting_type = SettingType.find(params[:setting_type_id])
    @setting_subject = SettingSubject.find(params[:setting_subject_id])
    @link = AdminSetting.find(params[:link_id])
    @value = JSON.parse(@link.value)
    @value["name"] = params["link_name"]
    @value["href"] = params["link_href"]
    @value["sequence"] = params["link_sequence"]
    if params["link_logo_file"]
      file = params["link_logo_file"]
      sanitize_filename(file.original_filename) #过滤文件名
      if not ["image/jpg", "image/jpeg", "image/png", "image/gif"].include? file.content_type.chomp.downcase
        render :edit_link and return
      end
      if file.original_filename
        filename = Time.now.strftime("%Y%m%d%H%M%S") + file.original_filename
        File.open("#{Rails.root}/public/uploads/links/#{filename}", "wb") do |f|
          f.write(file.read)
        end
        @value["logo"] = "/uploads/links/" + filename
      else
        render :edit_link and return
      end
    else
      @value["logo"] = params["link_logo"]
    end
    @link.value = @value.to_json
    if @link.save
      # 写入到Rails设置
      BBTangCMS::MetaCache.set_type_name_config_data("link", @link.id, @link.value)
      redirect_to "/admin/links_settings"
    else
      render :edit_link and return
    end
  end

  def delete_link
    @link = AdminSetting.find(params[:link_id])
    # 写入到Rails设置
    BBTangCMS::MetaCache.delete_type_name_config_data("link", @link.id)
    @link.delete
    respond_with
  end

end
