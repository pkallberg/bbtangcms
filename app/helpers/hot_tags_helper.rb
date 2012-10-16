module HotTagsHelper
  def taggable_type_mod
    ActsAsTaggableOn::Tagging.uniq.pluck(:taggable_type).collect{|mod| mod.constantize if mod.class_exists?}.compact
  end

end
