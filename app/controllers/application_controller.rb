class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :add_initial_breadcrumbs
  before_filter :create_profile

  attr_reader :current_action

  def default_url_options
    if Rails.env.production?
      { :host => "cms.bbtang.com",
        #:locale => I18n.locale
      }
    else
      {}
    end
  end


  # 强制创建profile
  def create_profile
      #breakpoint
    if current_user
      @profile=Profile.find_or_create_by_user_id(current_user.id)
      #profile_session @profile
      #if is_create_profile?(params)
          #Profile.create(:user_id=>current_user.id)
          #breakpoint
          #Profile.find_or_create_by_user_id(current_user.id)
          #redirect_to "/profiles/new" and return
      #end
    end
  end

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
