# encoding: utf-8
#require 'acts-as-taggable-on'
require 'askjane/meta_cache'  #缓存字典表使用方法函数
require 'askjane/app_util'
require 'askjane/redis'
require 'has_messages'
require 'find_city'
require 'internal_user'
require "sphinx/indexer"
#load user model from mmbk
require "user/mmbk_user"
require "user/mmbk_user_export_reporter"
#require 'will_paginate/pagination_list_link_renderer' # 自定义分页，显示更多
require "elasticsearch/indexer"
#require 'sanitize'  # 去除字符串中的html标签
#require 'rails_autolink'   # This is an extraction of the `auto_link` method from rails

# include the extension
ActiveRecord::Base.class_eval do
  include BBTangCMS::ActiveRecordExtensions
end

class String

  def cut_partial(length)
    if self.length > length
      self.first(length) + "..."
    else
      self
    end
  end

  def split_all(content = '')
    content = self if content.empty?
    content.split(/、|，|,|;|；|\ +|\||\r\n/) if content.class.eql? self.class
  end


  def class_exists?(class_name = nil)
    class_name = self if class_name.nil?
    #defined? Knowledge => nil
    # "Knowledge".constantize
    # Knowledge(id: integer, title: string, summary: text, content: text, body: text, timeline_ids: text, knowledgebase_category_id: integer, created_by: integer, created_name: string, updated_by: integer, deleted_at: datetime, deleted_by: integer, delta: boolean, created_at: datetime, updated_at: datetime, thanks_count: integer, forwarding_count: integer, comments_count: integer, views_count: integer, source_info: string, auto_tags: text, face_file_name: string, face_content_type: string, face_file_size: string)
    #defined? Knowledge  => "constant"
    #eval("#{class_name}.is_a?(Class)") if eval("defined?(#{class_name})") == "constant"
=begin
    begin
      class_obj = class_name.classify.constantize
    rescue
      # failure handling goes here
      return false
    end
    class_obj.is_a?(Class)
=end
    (class_name.capitalize.constantize.is_a?(Class) ? true : false rescue false) or (class_name.classify.constantize.is_a?(Class) ? true : false rescue false)
  end
end
