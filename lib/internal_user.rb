# coding: utf-8
require 'json'

class InternalUser
  attr_reader :internal_users

  if not File.exists?('lib/internal_user.json')
    puts 'internal_user.json not exists  ...'
    raise "internal_user.json not exists"
  else
    UserHash = JSON.parse File.read('lib/internal_user.json')
  end

  def initialize
    @internal_users = UserHash["internal_users"]
  end

  #["zhubin","xiaowang"]
  def user_list
    @internal_users.keys
  end

  #["121@qq.com","asd@abc.com"]
  def all_internal_email
    all_emails = []
    @internal_users.collect{|k,v| all_emails.concat v}
    all_emails
  end

  def user_email(name='')
    if user_list.include? name
      @internal_users[name]
    end
  end
end

if __FILE__==$0
  #************************以下测试代码*****************

  internal_user = InternalUser.new
  p internal_user.user_list
  p internal_user.all_internal_email
  p internal_user.user_email("朱斌")
end
