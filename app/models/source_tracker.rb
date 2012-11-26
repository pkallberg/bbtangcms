=begin
key
  platform
    email,web #,app
  from
    'mmbk','bbtang','mianhuatang'
  version_number# eg weekly_notify number
  #token#is uniq
  {platform: "email", from: "bbtang", version_number: "week1"}.to_param

key =  "from=bbtang&platform=email&version_number=week1"
source_tracker
  key
  platform
  from
  version_number
  #token
  ip
  url
rails g mongoid:model source_tracker key:string platform:string from:string version_number:string ip:string url:string
rails g scaffold_controller source_tracker key:string platform:string from:string version_number:string ip:string url:string created_at:datetime
=end
class SourceTracker
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  
  field :platform, type: String
  field :from, type: String
  field :version_number, type: String
  field :ip, type: String
  field :url, type: String
end
