class MMBKUser < ActiveRecord::Base
  establish_connection "ecshop"
  self.table_name = "mmbk_users"

  validates :email, :format => { :with => %r\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => :create }

end
