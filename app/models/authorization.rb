class Authorization < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :uid, :provider, :presence => true
  validates :uid, :uniqueness => { :scope => :provider }

  def to_s
    "#{provider} #{uid}"
  end
end
