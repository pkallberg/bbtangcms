class Recommend::RecommendBaseController < ApplicationController
  after_filter :add_initial_breadcrumbs


  #before_filter :require_login
  before_filter :authenticate_user!
  protected

  def require_login
    return redirect_to(admin_session_path) unless session[:logged_in]
  end

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end
  private
  def add_initial_breadcrumbs
    breadcrumbs.add :homepage, root_path
    breadcrumbs.add :recommend, recommend_dashboard_path
  end
end
