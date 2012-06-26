class Level < ActiveRecord::Base
  has_many :profiles, :order => "#{Profile.table_name}.created_at desc"
end
