#require 'acts-as-taggable-on'
require 'askjane/meta_cache'  #缓存字典表使用方法函数
require 'askjane/app_util'
require 'askjane/redis'
require 'has_messages'
require 'find_city'
require 'internal_user'
require "sphinx/indexer"
#require 'will_paginate/pagination_list_link_renderer' # 自定义分页，显示更多

#require 'sanitize'  # 去除字符串中的html标签
#require 'rails_autolink'   # This is an extraction of the `auto_link` method from rails

# include the extension
ActiveRecord::Base.class_eval do
  include BBTangCMS::ActiveRecordExtensions
end

class String

  def class_exists?(class_name = nil)
    class_name = self if class_name.nil?
    eval("#{class_name}.is_a?(Class)") if eval("defined?(#{class_name})") == "constant"
  end
end
