class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :add_initial_breadcrumbs
  before_filter :create_profile

  attr_reader :current_action

  #check_authorization :unless => :do_not_check_authorization?
  #check_authorization :unless => :devise_controller?
  check_authorization :unless => :do_not_check_authorization?


  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      if current_user.has_cms_role? :guest
        redirect_to root_url, :alert => exception.message
      else
        #render :file => "#{Rails.root}/public/403.html", :status => 403
        redirect_to "http://bbtang.com"
      end
    end
  end

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
  def do_not_check_authorization?
    respond_to?(:devise_controller?) or
    skip_rails_kindeditor?# or
    #condition_two?
    #respond_to?(:devise_controller?)# or respond_to?(:dashboard_controller?)
    #debugger
  end

  def skip_rails_kindeditor?
    true if params[:controller] == "kindeditor/assets"
  end

  #def condition_two?
  # ...
  #end

  protected

  def current_action
    params[:action]
  end

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end

  private

  def current_ability
    # I am sure there is a slicker way to capture the controller namespace
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join('/').camelize
    Ability.new(current_user, controller_namespace)
  end


end
