class Group < ActiveRecord::Base
  #establish_connection :group_development
  establish_connection "group_#{Rails.env}"

  #include SphinxIndexable::Group
end
