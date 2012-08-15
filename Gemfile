#source 'https://rubygems.org'
source 'http://ruby.taobao.org/'

gem 'rails', '3.2.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production, :development, :test do
  gem 'mysql2'
  gem "mongoid", "~> 3.0.2"
end

#Rails 3.* logs assets in the output from rails server. These messages are pretty verbose. Adding this gem to your project's Gemfile will suppress those messages.
group :development do
# gem 'quiet_assets', git: 'git@github.com:AgilionApps/quiet_assets.git', tag: 'v0.1.0'
  gem 'quiet_assets', '1.0.0'
end

#group :test do
#  gem 'sqlite3'
#end


# Gems used only for assets and not required
# in production environments by default.


# 用户登录
gem 'devise',"~> 2.0.4"
gem "devise-i18n", "~> 0.4.6"
gem 'omniauth','0.3.2'
gem 'json'
# 三方平台 OAuth 验证登陆
gem 'oauth'
gem "oauth_china", "~> 0.4.0"
#gem 'weibo'
#gem "weibo2", "~> 0.1.0"
#gem "weibo", "~> 0.0.11"

# 验证码
#gem 'simple_captcha', :git => 'git://github.com/galetahub/simple-captcha.git'
gem "galetahub-simple_captcha", "~> 0.1.3", :require => "simple_captcha"

# 表单 last commit: 2011-12-03
gem 'simple_form', :git => "git://github.com/plataformatec/simple_form.git"
#DynamicForm provides helpers to display the error messages of your models in your view templates.
#Wrap your objects with a helper to easily show them
gem "show_for", "~> 0.2.5"

#This is just a simple messaging generators for Rails 3.x, enable user to sending messages across the app.
gem "has_messages_generators", "~> 0.0.1"
# for has_messages_generators
gem "kaminari"
gem "ancestry"

#gem "twitter-bootstrap-rails", "~> 2.1.0"
#gem "sass-twitter-bootstrap-rails", "~> 1.0.2"
#This gem is meant to be used with bootstrap-sass.
#gem "bootswatch-rails", "~> 0.0.11"
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem "gritter", "~> 1.0.1"
  gem 'therubyracer'
  gem "less-rails", "~> 2.2.3"
  gem "less-rails-bootstrap", "~> 2.0.13"
  gem 'coffee-rails', '~> 3.2.1'
  gem "less-rails-bootswatch", "~> 0.2.11"
  gem 'uglifier', '>= 1.0.3'
end
#麵包屑
gem "breadcrumbs", "~> 0.1.6"

# 上传图片
#Paperclip is intended as an easy file attachment library for Active Record.
gem "paperclip", "~> 3.1.4"
gem "gravatar_image_tag", "~> 1.1.2"

gem 'jquery-rails', "~> 1.0.19"
#gem "prototype-rails", "~> 3.2.1"
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'rvm-capistrano'
gem "rails-settings-cached", "~> 0.2.1"

# To use debugger
group :development do
  gem 'thin'
  gem 'linecache19', '0.5.13'
  gem 'ruby-debug-base19', '0.11.26'
  gem 'ruby-debug19', :require => 'ruby-debug'

  #curl -OL http://rubyforge.org/frs/download.php/75414/linecache19-0.5.13.gem
  #curl -OL http://rubyforge.org/frs/download.php/75414/linecache19-0.5.13.gem
  #curl -OL http://rubyforge.org/frs/download.php/75415/ruby-debug-base19-0.11.26.gem
  #gem install linecache19-0.5.13.gem -- --with-ruby-include="${MY_RUBY_HOME/rubies/src}"
  #gem install ruby-debug-base19-0.11.26 -- --with-ruby-include="${MY_RUBY_HOME/rubies/src}"


  #other case
  #gem 'linecache19', :git => 'git://github.com/mark-moseley/linecache'
  #gem 'ruby-debug-base19x', '~> 0.11.30.pre4'
  #gem 'ruby-debug19'
end

# redis-search
#gem 'redis','~> 2.1.1'
#gem 'redis-namespace','~> 1.0.2'
#gem 'chinese_pinyin', '~> 0.3.0'
#gem 'rmmseg-cpp-huacnlee', '~> 0.2.8'
#gem 'redis-search', '0.7.0'

gem 'settingslogic', '2.0.6' #为使用yml文件作为配置
gem "carrierwave", "~> 0.6.2"  #Upload files in your Ruby applications, map them to a range of ORMs, store them on different backends.
gem 'rails_kindeditor', '~> 0.3.0' #for kindeditor
gem "mime-types", "~> 1.19"
gem 'sanitize','2.0.3'  #过滤html标签  requires Nokogiri >= 1.4.4  libxml2 >= 2.7.2
gem 'will_paginate', '3.0.2' #分页控件
gem "will_paginate_twitter_bootstrap", "~> 1.0.0"

gem "awesome_nested_set", "~> 2.1.3" #timelines表结构
gem 'cancan' # permission
#Role specific Permits for use with CanCan permission system
#gem "cancan-permits", "~> 0.3.12"
gem 'rails_autolink', '1.0.4'  #用于超链接中显示url， 直接点击跳转

#With ActsAsTaggableOn, you can tag a single model on several contexts, such as skills, interests, and awards. It also provides other advanced functionality.
gem 'acts-as-taggable-on', '~> 2.3.1'
gem "acts_as_follower", "~> 0.1.1"

#PaperTrail lets you track changes to your models' data. It's good for auditing or versioning. You can see how a model looked at any stage in its lifecycle, revert it to any version, and even undelete it after it's been destroyed.
gem 'paper_trail', '~> 2'

# sphinx搜索
gem 'thinking-sphinx','~> 2.0.7'

#Clean ruby syntax for writing and deploying cron jobs.
gem "whenever", "~> 0.7.3"

group :development, :test do
  #gem 'cucumber-rails'
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'webrat'
  gem 'factory_girl'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'nokogiri', '~> 1.5.0'
end
