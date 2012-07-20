class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :add_initial_breadcrumbs
  before_filter :create_profile
  before_filter :set_page_number

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
        sign_out current_user
        redirect_to "http://bbtang.com"
      end
    end
  end

  def default_url_options(options = {})
    options.merge! :host => "cms.bbtang.com" if Rails.env.production?
    options.merge! :page => session[:old_page] if session[:old_page].present?# and !(params[:page].eql? session[:old_page])
    options
    #if Rails.env.production?
    #  { :host => "cms.bbtang.com",
    #    #:locale => I18n.locale
    #  }
    #else
    #  {}
    #end
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

  def set_page_number
    if session[:old_controller].eql? params[:controller]
      #if (['update','show','edit','create','destroy'].include? session[:old_action])# and !(session[:old_action].eql? params[:action])
      model_class = params[:controller].classify.constantize if params[:controller].classify.class_exists?
      model_class = params[:controller].gsub(/\w+([\/]+)/,"").classify.constantize if params[:controller].gsub(/\w+([\/]+)/,"").classify.class_exists?


      if model_class.present?
        same_index_action = (params[:action].eql?(session[:old_action]) and params[:action].eql? "index" if params[:action].present? and session[:old_action].present?)
        diff_instance_id = !params[:id].eql?(session[:old_instance_id]) if params[:id].present? and session[:old_instance_id].present?
        same_page = session[:old_page].eql? params[:page]
        same_controller = session[:old_controller].eql? params[:controller]

        session[:old_page] = case true
          when (same_index_action and !same_page) then (params[:page].present? ? params[:page] : '1')
          when (same_index_action and same_page) then nil
          when diff_instance_id then nil
          when !same_controller  then nil
          when (!(params[:action].eql? "index") and !(session[:old_action].eql? "index") and !diff_instance_id) then  (session[:old_page].present? ? session[:old_page] : params[:page])
        end

      end

    end

    # save old_controller and old_action in session
    session[:old_controller] = params[:controller]
    session[:old_action] = params[:action]
    session[:old_instance_id] = params[:id]
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
