module BBTangCMS
  class MetaCache

=begin
    # 读取Rails字典表数据
    def self.get_data_by_id(table_name, id)
      if Rails.configuration.respond_to?("self_settings")
        Rails.configuration.self_settings[table_name + "_by_id"][id.to_s]
      else
        nil
      end
    end

    def self.get_data_by_name(table_name, name)
      if Rails.configuration.respond_to?("self_settings")
        Rails.configuration.self_settings[table_name + "_by_name"][name.to_s]
      else
        nil
      end
    end
=end
    # 读取Rails字典表数据
	#FIXME
	#however on production Rails.configuration.respond_to?("self_settings") is false
	#may be just because the write_config.rb require after the lib_core.rb #not work
	#so mv write_config to lib/ folder and load after the meta_cache but #not work
	# more info see #config/initializers/write_config.rb
	# 最后 不管 Rails.configuration.self_settings 有没有 都去读取一下数据库以数据库为准
    def self.get_data_by_id(table_name, id)
      model_class = table_name.classify.constantize if table_name.class_exists?
	  puts "get config data #{name} !!!!!!!!!#############################################################"  if Rails.env.development?
      data = nil
	  puts "is Rails.configuratio.self_settings present? #{Rails.configuration.respond_to?("self_settings")}"  if Rails.env.development?

	  if Rails.configuration.respond_to?("self_settings")
        cache_value = Rails.configuration.self_settings[table_name + "_by_id"][id.to_s]
        if cache_value.present?
          data = cache_value
        else	  
          if model_class.present? and  model_class.exists? :id => id
            data = model_class.find id
            Rails.configuration.self_settings["#{table_name}_by_id"][id.to_s] = data
          end
        end
      else
        if model_class.present? and  model_class.exists? :id => id
          data = model_class.find id
		  #Rails.configuration.self_settings["#{table_name}_by_id"][id.to_s] = data
        end
      end
	  puts "#{name} is #{data}"  if Rails.env.development?
	  return data
    end


    def self.get_data_by_name(table_name, name)
      model_class = table_name.classify.constantize if table_name.class_exists?
	  puts "get config data #{name} !!!!!!!!!#############################################################"  if Rails.env.development?
      data = nil
	  puts "is Rails.configuratio.self_settings present? #{Rails.configuration.respond_to?("self_settings")}"  if Rails.env.development?

	  if Rails.configuration.respond_to?("self_settings")
        cache_value = Rails.configuration.self_settings[table_name + "_by_name"][name.to_s]

        if cache_value.present?
		  data = cache_value
        else
          if model_class.exists? :name => name
            data = model_class.find_by_name name
            Rails.configuration.self_settings["#{table_name}_by_name"][name.to_s] = data
          end
        end
      else
        if model_class.exists? :name => name
          data = model_class.find_by_name name
          #Rails.configuration.self_settings["#{table_name}_by_name"][name.to_s] = data
        end
      end
	  puts "#{name} is #{data}"  if Rails.env.development?
	  return data
    end

    def self.get_config_data(name)
	  puts "get config data #{name} !!!!!!!!!#############################################################" if Rails.env.development?
      data = nil
	  puts "is Rails.configuratio.self_settings present? #{Rails.configuration.respond_to?("self_settings")}"  if Rails.env.development?
      if Rails.configuration.respond_to?("self_settings")
        cache_value = Rails.configuration.self_settings[name]
        if cache_value.nil?
          if AdminSetting.exists? :name => name
            data = AdminSetting.find_by_name(name).value 
            Rails.configuration.self_settings[name] = data
          end
        else
          data = cache_value
        end
      else
        if AdminSetting.exists? :name => name
          data = AdminSetting.find_by_name(name).value 
		  #Rails.configuration.self_settings[name] = data
        end
      end
	  puts "#{name} is #{data}"  if Rails.env.development?
	  return data
    end

    # 单个配置写入Rails设置（用于admin后台管理）
    def self.set_config_data(name, value)
      Rails.configuration.self_settings[name.to_s] = value.to_s
    end

    # 修改具有type_name的设置（用于admin后台管理，用于report_reason等，不包括代码参数设置）
    def self.set_type_name_config_data(type_name, id, value)
      Rails.configuration.self_settings[type_name.to_s + "s"][id.to_s] = value.to_s
    end

    def self.delete_type_name_config_data(type_name, id)
      Rails.configuration.self_settings[type_name.to_s + "s"].delete(id.to_s)
    end

    def self.get_all_type_name_config_data(type_name)
      Rails.configuration.self_settings[type_name.to_s + "s"]
    end

  end
end
