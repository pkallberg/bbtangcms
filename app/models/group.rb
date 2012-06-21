class Group < ActiveRecord::Base
  #establish_connection :group_development
  establish_connection "group_#{Rails.env}"

  define_index do
    indexes name
    where "deleted is null"
    #声明使用实时索引
    set_property :delta => true
  end
end
