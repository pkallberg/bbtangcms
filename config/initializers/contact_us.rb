require 'contact_us'
# Use this hook to configure contact mailer.
ContactUs.setup do |config|

  # ==> Mailer Configuration

  # Configure the e-mail address which email notifications should be sent from.  If emails must be sent from a verified email address you may set it here.
  # Example:
  # config.mailer_from = "contact@please-change-me.com"
  config.mailer_from = "service@bbtang.com"

  # Configure the e-mail address which should receive the contact form email notifications.
  #config.mailer_to = "864248765@qq.com"
  config.mailer_to = "snail_zhu@bbtang.com"
  # ==> Form Configuration

  # Configure the form to ask for the users name.
  config.require_name = false

  config.require_email = false

  # Configure the form to ask for a subject.
  config.require_subject = false

  # Configure the form gem to use.
  # Example:
  # config.form_gem = 'formtastic
  #config.form_gem = nil
  config.form_gem = 'simple_form'

end
