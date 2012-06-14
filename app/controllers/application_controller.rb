class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :add_initial_breadcrumbs

  attr_reader :current_action
  
  def bbtangcms_config
    @@bbtangcms_config = BBTangCMS::Config.default
  end

  private
  def add_initial_breadcrumbs
    breadcrumbs.add :homepage, root_path
  end

  
  protected

  def current_action
    params[:action]
  end

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end

end
