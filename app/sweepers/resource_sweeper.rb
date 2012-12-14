# encoding: utf-8
#http://rails-everyday.group.iteye.com/group/wiki/1160
#http://cobaltedge.com/rails-action-caching-with-query-parameters
class ResourceSweeper < ActionController::Caching::Sweeper
  #observe Knowledge  # This sweeper is going to keep an eye on the Knowledge model
  observe Setting.observe_models.split(" ").collect{|object| object.constantize if object.class_exists?}.compact.uniq
  # If our sweeper detects that a Knowledge was created call this
  def after_create(resource)
    expire_cache_for(resource)
  end
 
  # If our sweeper detects that a Knowledge was updated call this
  # http://stackoverflow.com/questions/6367396/filtering-sweeper-calls-in-rails
=begin
The current_sign_in_at and last_sign_in_at are the two fields that are updated by devise during sign_in and sign_out. This code makes the obvious assumption that you have no application logic of your own to update these fields and only devise updates them.
=end
  # but not work for me so skip User model
  def after_update(resource)
    #expire_cache_for(resource)
    unless resource.is_a? User and (resource.current_sign_in_at_changed? or resource.last_sign_in_at_changed?)
      expire_cache_for(resource)
    end
  end
 
  # If our sweeper detects that a Knowledge was deleted call this
  def after_destroy(resource)
    expire_cache_for(resource)
  end
=begin
  def after_save(resource)
    item = resource.is_a?(List) ? resource : resource.class
    resource_name = resource.class.name.underscore.pluralize
    expire_page(:controller => resource_name, :action => %w( show public feed ), :id => item.id)
    expire_action(:controller => resource_name, :action => "all")
    item.shares.each { |share| expire_page(:controller => resource_name, :action => "show", :id => share.url_key) }
  end
=end
  private
  def expire_cache_for(resource)
    resource_name = resource.class.name.underscore.pluralize

    controller_name = is_namespace_resources(resource.class) ? "/#{resource_name}" : resource_name
    # Expire the index page now that we added a new resource
    #expire_page(:controller => resource_name, :action => 'index')

    actions = %w( index show public feed ).collect{|action| action if route_checker?(controller_name,action)}.compact
    expire_page(:controller => controller_name, :action => actions, :id => resource.id)
    
    expire_action(:controller => controller_name, :action => actions)

    # Expire a fragment
    expire_fragment('all_available_'<< resource_name)
  end
  def namespace_resources
    [ "User","Version","Quiz",
    "QuizCollection","CmsRole",
    "Category","Identity","Timeline" ]
  end
  def is_namespace_resources(resource_name)
    namespace_resources.include?(resource_name)
  end
  def get_id(resource)
    #resource.is_a?(User) ? resource.id : resource.user_id
  end
  def get_observe_models
    observe_models = Setting.observe_models.split(" ")
    observe_models ||= ["Knowledge", "Note", "News", "Profile", "Question", "Quiz", "QuizCollection", "Subject", "User", "Answer", "Attachment", "CmsRole"]
    observe_models.collect{|object| object.constantize if object.class_exists?}.compact.uniq
  end
  def route_checker?(controller,action,opt={})
    route_exist = true
    begin
      url_for({:controller => controller, :action => action}.merge opt)
    rescue
      # route not exist
      route_exist = false
    end
    route_exist
  end
end
