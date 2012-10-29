# encoding: utf-8
#User.where("id > 1781").collect{|u| u.profile.destroy if u.profile.present?;u.destroy}
#User.where("id > 1781").collect{|u| u.profile.delete if u.profile.present?;u.authorizations=nil;u.save;u.delete}
require "logger"

def logger
  logger ||=  Logger.new("log/export_mmbk_user_#{Date.today.to_s}.log")
  logger.level = Logger::INFO
  logger
end

def find_mmbk_user
  if "MMBKUser".class_exists?
    logger.info "found MMBKUser model , then try to pick user we need ... "
    #MMBKUser.where("email is not NULL")
    #MMBKUser.select([:email, :sex, :birthday, :msn, :qq, :mobile_phone, :City])
    count = rand(200..300)
    auth_mmbk = Authorization.provider("mmbkoo").last
    
    if auth_mmbk.present?
      if MMBKUser.exists? auth_mmbk.uid.to_i
        last_mmbkuser = MMBKUser.find auth_mmbk.uid.to_i
        logger.info "last mmbk user on bbtang.com is found email: #{last_mmbkuser.email} user_id: #{last_mmbkuser.user_id} ... "
      end
      
      if last_mmbkuser.present? and auth_mmbk.created_at.today?
        #today_mmbk_users = MMBKUser.limit(count).where("email is not NULL and email != ''")
        puts "already export today ...."
        logger.error "#{Date.today} already export mmbk users, task will exit ...."
        today_mmbk_users = []

      else
        logger.info "today plan to export #{count} user ..."
        today_mmbk_users = MMBKUser.limit(count).where("email is not NULL and email != '' and user_id > #{last_mmbkuser.id}")
      end
    else
      logger.info "the first export ..."
      today_mmbk_users = MMBKUser.limit(count).where("email is not NULL and email != ''")
    end
  else
    logger.error "MMBKUser model not defined ..."
  end
end


def export_mmbk_user
=begin
    #can not work with limit option,also same as 'find_each'
    #MMBKUser.limit(count).where("email is not NULL and email != ''").find_in_batches(:batch_size => 1000) do |mmbk_users|

      #sleep(10) # Make sure it doesn't get too crowded in there!
      mmbk_users.each do |mmbk_user|
        if mmbk_user.valid?
          logger.info "pick mmbk_user user_id: #{mmbk_user.user_id} email #{mmbk_user.email}, then try to export to bbtang.com ..."
          export_user(mmbk_user: mmbk_user)
        end
      end
    end
=end
  real_count = 0
  today_mmbk_users = find_mmbk_user
  
  if today_mmbk_users.present?
    today_mmbk_users.each do |mmbk_user|
      if mmbk_user.valid? and not User.exists?(email: mmbk_user.email.strip)
        real_count += 1
        logger.info "pick mmbk_user user_id: #{mmbk_user.user_id} email #{mmbk_user.email}, then try to export to bbtang.com ..."
        export_user(mmbk_user: mmbk_user)
      end
    end

    logger.info "today pick (#{today_mmbk_users.count}) users, really export (#{real_count})  users."
    puts "today pick (#{today_mmbk_users.count}) users, really export (#{real_count})  users."
  end
end

def generate_reset_password_token(user)
  if user.present?
    user.reset_password_token = user.class.reset_password_token
    user.reset_password_sent_at = Time.now.utc
    user.reset_password_token
  end
end

def get_profile_date(params = {})
  mmbk_user = params.delete(:mmbk_user)
  if mmbk_user.present? and mmbk_user.class.to_s.eql? "MMBKUser"
    profile = {}
    [:birthday, :msn, :qq, :mobile_phone, :City, :sex].each do |col|
      if mmbk_user.send(col).present?
        coll_name = col
        case coll_name
        when :birthday
          #birthday = Time.at(mmbk_user.send(coll_name))
          profile.reverse_merge!(coll_name => mmbk_user.send(coll_name)) if mmbk_user.send(coll_name).present?
        when :City
          profile.reverse_merge!(:city => mmbk_user.send(coll_name).strip.gsub("f",""))
        when :sex
          profile.reverse_merge!(:gender => mmbk_user.send(coll_name))
        when :mobile_phone
          profile.reverse_merge!(:phone => mmbk_user.send(coll_name))
        else
          profile.reverse_merge!(coll_name => mmbk_user.send(coll_name).strip)
        end
      end
    end
    profile
  end
end

def export_user(params = {})
  mmbk_user = params.delete(:mmbk_user)
  if mmbk_user.present? and mmbk_user.class.to_s.eql? "MMBKUser"
    if not User.exists?(email: mmbk_user.email.strip)
      logger.info "create user #{mmbk_user.email}"
      password = Devise.friendly_token[0,10]
      user = User.new(:email => mmbk_user.email , :password => password)
      #user.password = password
      generate_reset_password_token(user)
      user.skip_confirmation!
      
      ActiveRecord::Base.transaction do
        #user.save
        user.create_oauth_user({provider: "mmbkoo", uid: mmbk_user.id}) if User.authorization(provider: "mmbkoo", uid: "#{mmbk_user.id}").empty?
        user.reset_authentication_token!
        #([:email, :sex, :birthday, :msn, :qq, :mobile_phone, :City])
        profile_date = get_profile_date(mmbk_user: mmbk_user)
        #profile_date.merge!(nickname: "mmbkoo",user_id: user.id)
        profile_date.merge!(nickname: "mmbkoo",user_id: user.id)
        profile = Profile.new(profile_date)
        profile.save
      end
      
      if user.valid? and user.profile.present?
        if Rails.env.production?
          logger.info "send mail about 'welcome_mmbkoo_user' to #{user.email} ..."
          mail = MMBKUserMail.welcome_mmbkoo_user(user.id)
          mail.deliver
        end
      end
    else
      logger.warn "user #{mmbk_user.email} already exists, skip ..."
    end
  end
end

#rake bbtangcms:notify:export_mmbk_user
namespace 'bbtangcms' do
  namespace 'user' do
    desc "export user in mmbkoo to bbtang"
    task :export_mmbk_user => :environment do
      logger.info "begin to export user in mmbkoo to bbtang ..."
      export_mmbk_user
    end
  end
end
=begin
def generate_reset_password_token(user)
  if user.present?
    user.reset_password_token = user.class.reset_password_token
    user.reset_password_sent_at = Time.now.utc
    user.reset_password_token
  end
end
emails = %w(123412341234@qq.com zuozhufirst@163.com zhubin_web@hotmail.com as181920@hotmail.com missandshine@126.com sunny@bbtang.com 864248765@qq.com)
users=emails.collect{|email| User.find_by_email email if User.exists? email: email}.compact
users.collect{|u| generate_reset_password_token(u);u.save}
users.each do |u|
  email = MMBKUserMail.welcome_mmbkoo_user(u.id)
  email.deliver
end
##
users = User.where("id >=1957 and id <= 2118")
users.each do |user|
  mmbk_user = MMBKUser.find_by_email user.email
  if mmbk_user.present? and User.authorization(provider: "mmbkoo", uid: "#{mmbk_user.id}").empty?
    user.create_oauth_user({provider: "bbmkoo", uid: mmbk_user.id})
  end
end
=end
