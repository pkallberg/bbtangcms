# encoding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :add_initial_breadcrumbs
  before_filter :add_model_breadcrumbs
  before_filter :create_profile
  before_filter :set_page_number
  before_filter :set_seo_meta


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
    options.merge! :page => session[:old_page]# if session[:old_page].present?# and !(params[:page].eql? session[:old_page])
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
      @current_user_profile=Profile.find_or_create_by_user_id(current_user.id)
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
    respond_to?(:devise_controller?) or skip_rails_kindeditor? or skip_messages?
    #condition_two?
    #respond_to?(:devise_controller?)# or respond_to?(:dashboard_controller?)
    #debugger
  end

  def skip_rails_kindeditor?
    true if params[:controller] == "kindeditor/assets"
  end

  def skip_messages?
    true if params[:controller] == "messages"
  end
  #def condition_two?
  # ...
  #end



  def current_action
    params[:action]
  end

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end

  def set_page_number

    #if (['update','show','edit','create','destroy'].include? session[:old_action])# and !(session[:old_action].eql? params[:action])
    model_class = params[:controller].classify.constantize if params[:controller].classify.class_exists?
    model_class = params[:controller].gsub(/\w+([\/]+)/,"").classify.constantize if params[:controller].gsub(/\w+([\/]+)/,"").classify.class_exists?


    if model_class.present?
      same_index_action = (params[:action].eql?(session[:old_action]) and params[:action].eql? "index" if params[:action].present? and session[:old_action].present?)
      diff_instance_id = !params[:id].eql?(session[:old_instance_id]) if params[:id].present? and session[:old_instance_id].present?
      same_page = session[:old_page].eql? params[:page]
      same_controller = session[:old_controller].eql? params[:controller]

      session[:old_page] = case true
        when (same_index_action and same_page) then nil
        when (same_index_action and !same_page) then (params[:page].present? ? params[:page] : '1')
        when (params[:page].present? and !(params[:page].eql? "1")) then params[:page]
        when diff_instance_id then nil
        when !same_controller  then nil
        when (!(params[:action].eql? "index") and !(session[:old_action].eql? "index") and !diff_instance_id) then  (session[:old_page].present? ? session[:old_page] : params[:page])
        when (same_controller and !(params[:page].present?) and (params[:action].eql?("index"))) then nil
        else
          nil
      end

    end

    # save old_controller and old_action in session
    session[:old_controller] = params[:controller]
    session[:old_action] = params[:action]
    session[:old_instance_id] = params[:id]
    session[:old_page] = nil if model_class.nil?

  end

  def set_seo_meta(title = '',meta_keywords = '', meta_description = '')
    g_obj = guessed_object
    if g_obj.present?
      [:title, :name, :nickname].each do |col|
        @page_title = g_obj.send col  if g_obj.respond_to? col
      end

      @meta_keywords = g_obj.tag_list.join(",") if g_obj.respond_to? :tag_list
      @meta_description = g_obj.summary if g_obj.respond_to? :summary
      @meta_description = g_obj.description if g_obj.respond_to? :description
    end

    if title.present?
      @page_title = "#{title}"
    end
    @meta_keywords = meta_keywords if meta_keywords.present?
    @meta_description = meta_description if meta_description.present?
  end

  def guessed_object
    @model_class = params[:controller].classify.constantize if params[:controller].classify.class_exists?
    @model_class = params[:controller].gsub(/\w+([\/]+)/,"").classify.constantize if params[:controller].gsub(/\w+([\/]+)/,"").classify.class_exists?

    if @model_class.present?
      @model_class.where(id: params[:id]).first if params[:id].present?
      #guessed_instance_variable_name = "@#{@model_class.name.singularize.downcase}"
      #if self.instance_variable_defined? guessed_instance_variable_name
      #  self.instance_variable_get guessed_instance_variable_name
      #end
    end
  end


  def add_model_breadcrumbs
    if self.class.constants.include? :Model_class
      model_class = self.class.const_get :Model_class
      name = I18n.t('.index', :default => I18n.t("helpers.links.index", :model => model_class.model_name.human))
      controller = params[:controller].gsub('/','_') if params[:controller].present?
      if model_class.model_name.singularize.eql? model_class.model_name.pluralize
        controller += "_index" if params[:controller].present?
      end
      route_name = "#{controller}_path"
      breadcrumbs.add name, self.send(route_name) if self.respond_to? route_name
    end
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
