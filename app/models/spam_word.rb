class SpamWord < Settingslogic
  source "#{Rails.root}/config/spam_words.yml"
  namespace Rails.env
end
