class Authorization < ActiveRecord::Base
  #scope :provider, ->(provider) { where(:provider => provider).order("created_at ASC") }
  scope :provider, ->(provider) { where(:provider => provider).order("id") }
  belongs_to :user
  validates :user_id, :uid, :provider, :presence => true
  validates :uid, :uniqueness => { :scope => :provider }

  def to_s
    "#{provider} #{uid}"
  end
end
