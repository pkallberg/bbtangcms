class Level < ActiveRecord::Base
  has_many :profiles, :order => "#{Profile.table_name}.created_at desc"

  def to_s
    self.name if self.name.present?
  end
end
