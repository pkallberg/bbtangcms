MONGO_CONFIG = YAML.load_file("#{Rails.root}/config/mongo.yml")[Rails.env]

MongoConn = Mongo::Connection.new(MONGO_CONFIG["host"], MONGO_CONFIG["port"])
BBTDB = MongoConn.db(MONGO_CONFIG["database"])



#Bbtlog = BBTDB.collection "bbt_log"
=begin
  关系模型，
  字段包括  ：
         follower_id、follower_type
         followable_id、followable_type
         follow_action可以是关注，好友、收藏等
         /blocked
         create_at/updated_at
=end
#Relation = BBTDB.collection "Relation"

# 各类推送
#Rmdindex = BBTDB.collection "recommend_recommend_hindices"
#Rmdtags  = BBTDB.collection "recommend_recommend_tags"
#Rmdptags  = BBTDB.collection "recommend_recommend_ptags"
#Rmdothers = BBTDB.collection "recommend_recommend_others"
#Rmdusers = BBTDB.collection "recommend_recommend_users"
#BBTContact = BBTDB.collection "contacts"

# 
Eventlog = BBTDB.collection "event_log"

# Quiz
#QuizCollection = BBTDB.collection "quiz_collections"


#ExpertCategory = BBTDB.collection "recommend_expert_categories"
#VipCategory = BBTDB.collection "recommend_vip_categories"
