class Setting < Settingslogic
  source "#{Rails.root}/config/bbtangcms.yml"
  namespace Rails.env
end
