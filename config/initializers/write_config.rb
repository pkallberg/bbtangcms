# 将字典表、各配置写入Rails配置

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
