# coding: utf-8
class News < ActiveRecord::Base
  include BaseModel  #for 敏感词验证
  acts_as_taggable_on :tags
  before_validation :repear_save
  before_save :update_tags_count

  attr_accessor :soft_deleted

  attr_accessible :title, :body,
                  :deleted_at, :source_info,
                  :views_count, :thanks_count, :created_at, :updated_at,
                  :updated_by_id, :tag_list, :created_by_id, :soft_deleted

  # 基础参数验证
  validates :title, :content, :created_by_id, :presence => true
  validates_uniqueness_of :title

  def if_soft_deleted(soft_deleted =nil, user = nil)
    if soft_deleted.present? and user.present?
      if ["true","1",1,true].include? soft_deleted
        self.deleted_at = Time.now
        self.deleted_by_id = user.id if user.id.present?
      else
        self.deleted_at = nil
        self.deleted_by_id = nil
      end
    end
  end

  def deleted_user
    User.find_by_id(self.deleted_by_id) if (self.deleted_by_id.present?) and (User.exists? self.deleted_by_id)
  end

  def updated_user
    User.find_by_id self.updated_by_id if self.updated_by_id.present?
  end

  def created_user
    User.find_by_id self.created_by_id if self.created_by_id.present?
  end

  def repear_save
    self.content = Sanitize.clean(self.body).strip
    ##(/，|,|;|；|\ +|\||\r\n/)
    self.tag_list = sort_tag_list(self.tag_list) if self.respond_to? "tag_list" and self.tag_list.present?
  end

  def update_tags_count
    tags_list = [:tags]
    tags_list.each do |tag|
      tag = tag.to_s.singularize
      if self.respond_to?("#{tag}_list_changed?")
        #if self.send("#{tag}_list_changed?") == true
        t_list_changes = self.send("#{tag}_list_changes")
        if t_list_changes.present? and t_list_changes.count == 2
          if t_list_changes.first.class == String
            old_t = t_list_changes.first.split(',').collect {|t| t.gsub(' ',"")}    else
            old_t = t_list_changes.first
          end
          if t_list_changes.last.class == String
            new_t = t_list_changes.last.split(',').collect {|t| t.gsub(' ',"")}    else
            new_t = t_list_changes.last
          end
          set_tags_count(old_tags = old_t,new_tags = new_t)
        end
      end
    end
  end

  def set_tags_count(old_tags = [],new_tags = [],count_type=self.class.to_s.downcase.pluralize)

    #add count
    insert_tags = new_tags - old_tags
    if insert_tags.present?
      insert_tags.each do |t|
        if ActsAsTaggableOn::Tag.where(name: t).present?
          tag = ActsAsTaggableOn::Tag.where(name: t).first
          tag.send("#{count_type}_count=",tag.send("#{count_type}_count").to_i.next) if tag.respond_to? "#{count_type}_count"
          tag.save
        end
      end
    end
    # pred  count
    pred_tags = old_tags - new_tags
    if pred_tags.present?
      pred_tags.each do |t|
        if ActsAsTaggableOn::Tag.where(name: t).present?
          tag = ActsAsTaggableOn::Tag.where(name: t).first
          tag.send("#{count_type}_count=",tag.send("#{count_type}_count").to_i.pred) if tag.respond_to? "#{count_type}_count"
          tag.save
        end
      end
    end
  end

  private
  def sort_tag_list(tag_list= [])
    tag_str = ''
    tag_list.each do |tag|
      tag_str = tag_str+ ',' + tag
    end
    tag_str.to_s.split(/，|,|;|；|\ +|\||\r\n/) if tag_str.present?
  end
end
