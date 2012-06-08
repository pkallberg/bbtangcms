require "redis"
require "redis-namespace"
require "redis-search"
# don't forget change namespace
redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")["redis"] 
redis = Redis.new(:host => redis_config["host"], :port => redis_config["port"])
# We suggest you use a special db in Redis, when you need to clear all data, you can use flushdb command to clear them.
redis.select(3)
# Give a special namespace as prefix for Redis key, when your have more than one project used redis-search, this config will make them work fine.
redis = Redis::Namespace.new("askjane:redis_search", :redis => redis)
Redis::Search.configure do |config|
  config.redis = redis
  config.complete_max_length = 100
  config.pinyin_match = true
end

# rake db:seed 之前，把这几个new注释掉，
# 否则可能会先于自定义参数加载，导致找不到自定义参数
#User.new
#Question.new
#Tag.new
#Group.new

