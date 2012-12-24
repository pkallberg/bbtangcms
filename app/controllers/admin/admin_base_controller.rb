# coding: utf-8
class Admin::AdminBaseController < ApplicationController
  layout "layouts/admin"
  before_filter :add_initial_breadcrumbs

  SettingSubject =  {
                      "base_settings"=> "基本设置",
                      "links_settings"=> "友情链接",
                      #"ads" => "广告设置", 
                      "email_settings"=> "邮件设置",
                      "seo_settings"=> "SEO设置",
                      "code_settings"=> "代码参数设置",
                      "ip_settings"=> "访问IP设置"}
  SubjectType =  {
                      "base_settings" => 1,
                      "links_settings" => 1,
                      #"ads" => 3, 
                      "email_settings" => 1,
                      "seo_settings" => 1,
                      "code_settings" => 1,
                      "ip_settings" => 3}
                    
  SettingType = {1=>"站点设置", 2=>"版面设置", 3=>"其它设置"}

  # 过滤文件名
  def sanitize_filename(filename)
    filename.strip.tap do |name|
      # NOTE: File.basename doesn't work right with Windows paths on Unix
      # get only the filename, not the whole path
      name.sub! /\A.*(\\|\/)/, ''
      # Finally, replace all non alphanumeric, underscore
      # or periods with underscore
      name.gsub! /[^\w\.\-]/, '_'
    end
  end

  #before_filter :require_login
  protected

  def require_login
    return redirect_to(new_session_path) unless session[:logged_in]
  end

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end
  private
  def add_initial_breadcrumbs
    breadcrumbs.add :homepage, root_path
    #breadcrumbs.add :recommend, recommend_dashboard_path
    breadcrumbs.add ".namespace.admin", admin_base_settings_path
    add_setting_subject_breadcrumbs
  end
  def add_setting_subject_breadcrumbs

    controller = params[:controller].gsub('/','_') if params[:controller].present?
    route_name = "#{controller}_path"

    subject_type = params[:controller].gsub(/\w+([\/]+)/,"")
    breadcrumbs.add "admin.base_settings", self.send(route_name) if self.respond_to? route_name

    request_path = request.fullpath
    edit_action = "#{params[:action]}" if params[:action].present? and (params[:action].include? "edit")
    edit_subject_name = edit_action.present? ? "#{params[:action]}_#{controller.singularize}_path" : nil
    breadcrumbs.add "编辑", request_path if edit_subject_name.present? and (self.respond_to? edit_subject_name)
  end
end
