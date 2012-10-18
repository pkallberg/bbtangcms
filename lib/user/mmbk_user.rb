class MMBKUser < ActiveRecord::Base
  establish_connection "ecshop"
  self.table_name = "mmbk_users"

  attr_accessible :email, :sex, :birthday, :msn, :qq, :mobile_phone, :City

  def to_s
    email.present? ? "#{email}" : "mmbkoo user #{id}"
  end
end
