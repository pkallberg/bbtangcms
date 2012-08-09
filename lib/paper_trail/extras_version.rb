class Version

  #class << self
  def object_hash
    YAML.load self.object if self.object.present?
  end

  def whodoit
    User.find_by_id self.whodunnit if self.whodunnit.present? and User.exists? self.whodunnit
  end

  def item_type_human
    if self.item_type.present? and self.item_type.to_s.class_exists?
      self.item_type.classify.constantize.model_name.human.pluralize
    else
      self.item_type
    end
  end
  #end
end
