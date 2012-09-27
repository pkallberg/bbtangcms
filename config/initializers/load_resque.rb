#load_resque.rb
require 'resque'

#ActionMailer::Base.delivery_method = :sendmail

class AsyncMailer < ActionMailer::Base
  include Resque::Mailer
  self.default :from => BBTangCMS::MetaCache.get_config_data("email_account"),
               #:abcc => 'email_logger@test.lindsaar.net',
               :reply_to => BBTangCMS::MetaCache.get_config_data("email_reply_address"),
               :sender => BBTangCMS::MetaCache.get_config_data("email_account")
end
