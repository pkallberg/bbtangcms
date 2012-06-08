module BBTangCMS
  class DefineRedis
    
    def self.define_recommendation_redis(namespace, name)
      redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")["redis"] 
      redis = Redis.new(:host => redis_config["host"], :port => redis_config["port"])
      redis = Redis::Namespace.new(namespace.downcase + '_' + name, :redis => redis)
      return redis
    end
    
    def self.define_namespace_redis(namespace)
      redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")["redis"] 
      redis = Redis.new(:host => redis_config["host"], :port => redis_config["port"])
      redis = Redis::Namespace.new(namespace.downcase, :redis => redis)
      return redis
    end
    
  end
end
