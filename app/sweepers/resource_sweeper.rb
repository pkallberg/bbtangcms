class ResourceSweeper < ActionController::Caching::Sweeper
  #observe Knowledge  # This sweeper is going to keep an eye on the Knowledge model
  observe Setting.observe_models.split(" ").collect{|object| object.constantize if object.class_exists?}.compact.uniq
  # If our sweeper detects that a Knowledge was created call this
  def after_create(resource)
    expire_cache_for(resource)
  end
 
  # If our sweeper detects that a Knowledge was updated call this
  def after_update(resource)
    expire_cache_for(resource)
  end
 
  # If our sweeper detects that a Knowledge was deleted call this
  def after_destroy(resource)
    expire_cache_for(resource)
  end
=begin
  def after_save(resource)
    item = resource.is_a?(List) ? resource : resource.class
    resource_name = resource.class.underscore.pluralize
    expire_page(:controller => resource_name, :action => %w( show public feed ), :id => item.id)
    expire_action(:controller => resource_name, :action => "all")
    item.shares.each { |share| expire_page(:controller => resource_name, :action => "show", :id => share.url_key) }
  end
=end
  private
  def expire_cache_for(resource)
    #item = resource.is_a?(List) ? resource : resource.class
    item = resource.class
    resource_name = resource.class.underscore.pluralize

    controller_name = is_namespace_resources(resource.class) ? "/#{resource_name}" : resource_name
    # Expire the index page now that we added a new resource
    #expire_page(:controller => resource_name, :action => 'index')
    
    expire_page(:controller => controller_name, :action => %w( index show public feed ), :id => item.id)
    
    expire_action(:controller => controller_name, :action => "all")
    item.shares.each { |share| expire_page(:controller => controller_name, :action => "show", :id => share.url_key) }
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
end