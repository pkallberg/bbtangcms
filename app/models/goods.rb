# coding: utf-8
class Goods < ActiveRecord::Base
  acts_as_taggable_on :tags, :category_majors, :category_smalls
  before_validation :repear_save
  attr_accessible :name, :category_major_list, :category_small_list, :created_at,
                  :updated_at, :tag_list, :url, :avatar_url

  validates :name, :presence => true

  def to_s
    name.present? ? "#{name}" : "goods #{id}"
  end

  def repear_save
    ##(/，|,|;|；|\ +|\||\r\n/)
    self.tag_list = sort_tag_list(self.tag_list) if self.tag_list.present?
    self.category_major_list = sort_tag_list(self.category_major_list) if self.category_major_list.present?
    self.category_small_list = sort_tag_list(self.category_small_list) if self.category_small_list.present?
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
