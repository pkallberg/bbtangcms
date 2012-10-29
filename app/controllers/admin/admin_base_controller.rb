# coding: utf-8
class Admin::AdminBaseController < ApplicationController
  layout "layouts/admin"
  before_filter :add_initial_breadcrumbs

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
    subject = SettingSubject.find_by_controller_name("#{subject_type}")
    subject_name = subject.present? ? subject.name : subject_type
    breadcrumbs.add subject_name, self.send(route_name) if self.respond_to? route_name

    request_path = request.fullpath
    edit_action = "#{params[:action]}" if params[:action].present? and (params[:action].include? "edit")
    edit_subject_name = edit_action.present? ? "#{params[:action]}_#{controller.singularize}_path" : nil
    breadcrumbs.add "编辑", request_path if edit_subject_name.present? and (self.respond_to? edit_subject_name)
  end
end
