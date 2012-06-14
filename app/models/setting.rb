class Setting < Settingslogic
  source "#{Rails.root}/config/bbtangcms.yml"
  namespace Rails.env
  theme = %w(amelia cerulean cyborg journal readable simplex slate spacelab spruce superhero united)
  #this not inset to db
  attr_accessor :today_theme
  self.today_theme = theme[Time.now.day.divmod(theme.count)[1]]
end
