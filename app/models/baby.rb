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

  # just a helper method for the view
  def show_gender
    Gender[gender.to_i]
  end
end
