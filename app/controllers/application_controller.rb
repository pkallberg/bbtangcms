class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :require_login
  #before_filter :authenticate_user!
  before_filter :add_initial_breadcrumbs

  attr_reader :current_action

  private
  def add_initial_breadcrumbs
    breadcrumbs.add :homepage, root_path
  end

  
  protected

  def current_action
    params[:action]
  end

  def require_login
    return redirect_to(admin_session_path) unless session[:logged_in]
  end

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end

end
