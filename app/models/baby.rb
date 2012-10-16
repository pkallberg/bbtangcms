class Baby < ActiveRecord::Base
  belongs_to :profile
  Gender_0  = "0"
  Gender_1  = "1"
  Gender_2  = "2"

  Gender = {
    #Gender_0        => "#{I18n.t('activerecord.attributes.baby.gender.gender_0')}",
    Gender_2        => "#{I18n.t('activerecord.attributes.baby.gender.gender_2')}",
    Gender_1        => "#{I18n.t('activerecord.attributes.baby.gender.gender_1')}"

  }

  validates_inclusion_of :gender, :in => Gender.keys, :allow_nil=>true,
      :message => "{{value}} must be in #{Gender.values.join ','}"

  def to_s
    name.present? ? "#{name}" : "baby #{id}"
  end

  def age
    return nil unless self.birthday?
    today = Date.today
    age = today.year - birthday.year
    age -= 1 if today.month < birthday.month || (today.month == birthday.month && today.mday < birthday.mday)
    age
  end

  def birthday_arrive_in?(days = 0)
    pre_birthday = Date.today + days.to_i
    return nil unless self.birthday?
    (pre_birthday.strftime('%m%d') == birthday.strftime('%m%d')) and self.age > 0
  end

  def birthday_today?
    birthday_arrive_in? and self.age > 0
  end

  # just a helper method for the view
  def show_gender
    Gender[gender.to_i]
  end
end
