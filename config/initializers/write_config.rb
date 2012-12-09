# 将字典表、各配置写入Rails配置
=begin
Rails has 5 initialization events which can be hooked into (listed in the order that they are ran):
* before_configuration: This is run as soon as the application constant inherits from Rails::Application. The config calls are evaluated before this happens.
* before_initialize: This is run directly before the initialization process of the application occurs with the :bootstrap_hook initializer near the beginning of the Rails initialization process.
* to_prepare: Run after the initializers are ran for all Railties (including the application itself), but before eager loading and the middleware stack is built. More importantly, will run upon every request in development, but only once (during boot-up) in production and test.
* before_eager_load: This is run directly before eager loading occurs, which is the default behaviour for the production environment and not for the development environment.
* after_initialize: Run directly after the initialization of the application, but before the application initializers are run
=end
#http://api.rubyonrails.org/classes/Rails/Railtie/Configuration.html
# Not work on production
#BBTangCMS::Application.config.after_initialize do

# 这个写法太绕了,从数据库读取的数据去初始化 model的 一些验证参数，坑爹
# production 环境会在应用加载的时候 初始化 model class(如下) 怎么办？？？？
# 比如 这样: Creating scope :page. Overwriting existing method AdminSetting.page.
# 最终在 prouduction 环境 初始化的时候 实际上 还是读取的数据库的数据 而不是 'BBTangCMS::Application.config.self_settings'
# to_prepare 的时候 基于model的 hash 状态字段的多语言加载不完全的情况
BBTangCMS::Application.config.after_initialize do
  BBTangCMS::Application.config.self_settings = {}

  ################ 字典表 #################

  # model_objects id => name
  model_objects = {}
  ModelObject.all.each do |m|
    model_objects[m.id.to_s] = m.name
  end
  BBTangCMS::Application.config.self_settings["model_objects_by_id"] = model_objects

  # model_objects name => id
  model_objects = {}
  ModelObject.all.each do |m|
    model_objects[m.name.to_s] = m.id
  end
  BBTangCMS::Application.config.self_settings["model_objects_by_name"] = model_objects

  # message_types id => name
  message_types = {}
  MessageType.all.each do |type|
    message_types[type.id.to_s] = type.name
  end
  BBTangCMS::Application.config.self_settings["message_types_by_id"] = message_types

  # message_types name => id
  message_types = {}
  MessageType.all.each do |type|
    message_types[type.name.to_s] = type.id
  end
  BBTangCMS::Application.config.self_settings["message_types_by_name"] = message_types

  # levels id => name
  levels = {}
  Level.all.each do |level|
    levels[level.id.to_s] = level.name
  end
  BBTangCMS::Application.config.self_settings["levels_by_id"] = levels

  # levels name => id
  levels = {}
  Level.all.each do |level|
    levels[level.name.to_s] = level.id
  end
  BBTangCMS::Application.config.self_settings["levels_by_name"] = levels



  ################ SEO配置 ##################

  # title
  seos = {}
  AdminSetting.where(["type_name=?", "seo"]).each do |line|
    seos[line.name] = line.value
  end
  BBTangCMS::Application.config.self_settings["seos"] = seos


  ################ 举报原因 设置 ##################

  report_reasons = {}
  AdminSetting.where(["type_name=?", "report_reason"]).each do |line|
    report_reasons[line.id.to_s] = line.value
  end
  BBTangCMS::Application.config.self_settings["report_reasons"] = report_reasons


  ################ 友情链接 设置 ##################

  links = {}
  AdminSetting.where(["type_name=?", "link"]).each do |line|
    links[line.id.to_s] = line.value
  end
  BBTangCMS::Application.config.self_settings["links"] = links


  ################ 代码参数设置 ################

  AdminSetting.where(["type_name = ?", "code"]).each do |line|
    BBTangCMS::Application.config.self_settings[line.name] = line.value
  end


  ################ 其它参数设置 ################

  AdminSetting.where(["type_name is null"]).each do |line|
    BBTangCMS::Application.config.self_settings[line.name] = line.value
  end


end
