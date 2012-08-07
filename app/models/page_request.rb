class PageRequest
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  #attr_accessible :path, :page_duration, :view_duration, :db_duration
  field :path, type: String
  field :page_duration, type: String
  field :view_duration, type: String
  field :db_duration, type: String

end
