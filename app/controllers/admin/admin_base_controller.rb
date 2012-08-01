class Admin::AdminBaseController < ApplicationController
  layout "layouts/admin"
  after_filter :add_initial_breadcrumbs

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
    breadcrumbs.add :admin, admin_base_settings_path
  end
end
