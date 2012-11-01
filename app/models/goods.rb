# coding: utf-8
class Goods < ActiveRecord::Base
  #tags: '相关标签',categories: '分类标签', timelines: '适用年龄段', identities: '对象', category_majors: '产品大类', category_smalls: '产品小类',brands: '品牌'
  acts_as_taggable_on :tags, :categories, :timelines, 
                      :identities, :category_majors, :category_smalls, :brands
  before_validation :repear_save
  attr_accessible :name, :url, :avatar_url,:created_at,
                  :updated_at, :tag_list, :category_list, 
                  :timeline_list, :identity_list, :category_major_list,
                  :category_small_list, :brand_list

  validates :name, :presence => true

  def to_s
    name.present? ? "#{name}" : "goods #{id}"
  end

  def repear_save
    ##(/，|,|;|；|\ +|\||\r\n/)
    all_tags =[:tag_list, :category_list, :timeline_list,\
     :identity_list, :category_major_list, :category_small_list, :brand_list]
     
    all_tags.each do |t|
      self.send("#{t.to_s}=", self.send(t).split_all) if self.send(t).present? and self.send(t).class.eql? String
    end
    #self.tag_list = sort_tag_list(self.tag_list) if self.tag_list.present?
  end

  private
  def sort_tag_list(tag_list= [])
    tag_str = ''
    tag_list.each do |tag|
      tag_str = tag_str+ ',' + tag
    end
    tag_str.to_s.split(/，|、|,|;|；|\ +|\||\r\n/) if tag_str.present?
  end
end
