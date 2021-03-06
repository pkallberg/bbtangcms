# encoding: utf-8
#User.where("id > 1781").collect{|u| u.profile.destroy if u.profile.present?;u.destroy}
#User.where("id > 1781").collect{|u| u.profile.delete if u.profile.present?;u.authorizations=nil;u.save;u.delete}
require "logger"

def logger
  logger ||=  Logger.new("log/export_mmbk_user_#{Date.today.to_s}.log")
  logger.level = Logger::INFO
  logger
end

def yesterday_export_reporter
  if "MmbkUserExportReporter".class_exists?
    mmbk_user_export_reporter = MmbkUserExportReporter.last
    if mmbk_user_export_reporter.present? and mmbk_user_export_reporter.created_at.to_date.eql? 1.day.ago.to_date
      mmbk_user_export_reporter
    end
  end
end

def today_export_reporter
  if "MmbkUserExportReporter".class_exists?
    mmbk_user_export_reporter = MmbkUserExportReporter.last
    if mmbk_user_export_reporter.present? and mmbk_user_export_reporter.created_at.to_date.eql? DateTime.now.to_date
      mmbk_user_export_reporter
    end
  end
end

def get_last_mmbk_user_by_auth
  auth_mmbk = Authorization.provider("mmbkoo").last
  if auth_mmbk.present?
    last_mmbkuser = MMBKUser.find auth_mmbk.uid.to_i
  end
end

def is_last_auth_mmbk_yesterday?
  auth_mmbk = Authorization.provider("mmbkoo").last
  (auth_mmbk.created_at.to_date >= 1.day.ago.to_date) if auth_mmbk.present?
end

def find_mmbk_user
  if "MMBKUser".class_exists?
    logger.info "found MMBKUser model , then try to pick user we need ... "
    #MMBKUser.where("email is not NULL")
    #MMBKUser.select([:email, :sex, :birthday, :msn, :qq, :mobile_phone, :City])
    count = rand(200..300)
    auth_mmbk = Authorization.provider("mmbkoo").last

    last_mmbkuser = yesterday_export_reporter.last_mmbk_user if yesterday_export_reporter.present?
    last_mmbkuser ||= get_last_mmbk_user_by_auth
    
    unless is_last_auth_mmbk_yesterday?
      now_time = DateTime.now
      #如果出现几天没有导入用户则，以(天数-1)乘以最小范围值
       distance_day = (now_time.year - auth_mmbk.created_at.year) * now_time.yday + (now_time.month - auth_mmbk.created_at.month) * now_time.mday + (now_time.day - auth_mmbk.created_at.day)
       logger.info "you last export at #{distance_day} ago, so add #{distance_day}*200 to plan_count"
       count = count + (distance_day - 1)*200 
    end

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
	logger.info "create today's MmbkUserExportReporter record ..."
	MmbkUserExportReporter.create(plan_count:count)
	today_mmbk_users 
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
    if today_export_reporter.present?
      logger.info "all user selected already export to bbtang.com now update mmbk_user_export_reporter."
      today_export_reporter.update_attributes(pick_count: today_mmbk_users.count, real_count: real_count,  last_mmbk_user_id: today_mmbk_users.last.user_id)
      logger.info "today's reporter #{today_export_reporter.to_json}"
      puts "today's reporter #{today_export_reporter.to_json}"
    else
      logger.info "today pick (#{today_mmbk_users.count}) users, really export (#{real_count})  users."
      puts "today pick (#{today_mmbk_users.count}) users, really export (#{real_count})  users."
    end
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

#pick oauth user begin one user.id and with limit count
def oauth_users_no_sign_in(email, count = 200, provider = 'mmbkoo')
  if email.present? and User.exists? email: email
    user = User.find_by_email email
    User.joins(:authorizations).where("authorizations.provider = '#{provider}' and not(users.sign_in_count > 0) and users.id > #{user.id}").limit(count.to_i)
  end
end

#rake bbtangcms:user:export_mmbk_user
namespace 'bbtangcms' do
  namespace 'user' do
    desc "export user in mmbkoo to bbtang"
    task :export_mmbk_user => :environment do
      logger.info "begin to export user in mmbkoo to bbtang ..."
      export_mmbk_user
    end
    
    #rake bbtangcms:user:mmbk_ad_for_mmbk_users_no_sign_in["njzhaoguobin@126.com","200"]
    #NOTICE args 有个坑 count 应该是 内置的 所以下面的 args.count 是两个参数 而不是 '200',要么不用 'count' or args[:count]
    desc "pick mmbk user which later than specific user and send an email"
    task :mmbk_ad_for_mmbk_users_no_sign_in, [:email, :users_count] => :environment do |t, args|
      args.with_defaults(:users_count => "200")
      if args.email.present?
        #logger.info "begin to pick mmbk user which later than #{args.email} and send email ..."
        puts "begin to pick mmbk user which later than #{args.email} and send email ..."
        users = oauth_users_no_sign_in(email = args.email, count = args[:users_count].to_i)
        users.each do |user|
          puts "pick user #{user} ... "
          if Rails.env.production?
            puts "send mail to #{user} ... "
            MMBKUserMail.ad_mmbkoo_user(user.id).deliver
          end
        end
      else
        puts "No email supplied"
      end
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
