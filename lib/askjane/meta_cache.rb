module BBTangCMS
  class MetaCache
    
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
    
    # 读取各种设置数据
    def self.get_config_data(name)
      if Rails.configuration.respond_to?("self_settings")
        Rails.configuration.self_settings[name]
      else
        nil
      end
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

