def logger(task_name = "logger")
  logger ||=  Logger.new("log/#{task_name}_notify_#{Date.today.to_s}.log")
  logger.level = Logger::INFO
  logger
end

def newest_obj(mod = "",conditions = [], t_count = "1", unit = "hours")
  #User.where("id != ?", exclude_ids)
  if mod.present?
    mod = mod.classify.constantize if mod.class == String
    s_time = t_count.to_i.send(unit).send("ago") if t_count.to_i > 0
    s_time ||= 1.hours.ago
    if mod_list.present?
     mod_list = mod_list.where(:created_at => s_time .. DateTime.now)
     conditions.present? ? mod_list.where(conditions) : mod_list
    else
      []
    end
  end
end

def pre_birthday_users(pre_days = 0)
  Profile.select(["profiles.id", :birthday, :user_id, :notify_via_email]).compact.collect{|item| item.id if item.birthday_arrive_in?(pre_days.to_i)}.compact
end

def pre_baby_birthday_users(pre_days = 0)
  #Baby.select([:birthday, :profile_id])
  #Baby.joins(:profile).select(["babies.birthday", :user_id, :notify_via_email])
  Baby.joins(:profile).select(["babies.birthday","babies.id", :user_id, :notify_via_email]).compact.collect{|item| item.id if item.birthday_arrive_in?(pre_days.to_i)}.compact
end

#pick_user_and_send_mail(type = "",options = {festival: "",template_name: ""})
def pick_user_and_send_mail(type = "",options = {})
  # Profile.where("age > 21").find_in_batches
  User.joins(:profile).find_in_batches(:batch_size => 500) do |items|
    sleep(25) # Make sure it doesn't get too crowded in there!
    #items.collect{|item| [item.email,item.profile.notify_via_email]}
    items.each do |item|
      #UserMail.send("#{type}_notify",item.email,festival).deliver if item.profile.notify_via_email.present?
      if Rails.env.production?
        puts "send mail to #{item}"
        UserMail.send("#{type}_notify",item.email,options = options).deliver
      else
        puts "pick user #{item}"
      end
      #UserMail.send("#{type}_notify",item.email,festival)
    end
  end
end

namespace 'bbtangcms' do
  namespace 'notify' do
    desc "pick up questions inside a time range and send a mail"
    task :new_question_notify => :environment do
      #questions = newest_obj(mod = "Question", t_count = "10", unit = "minutes").compact.uniq#params picked follw queue order when method defined
      questions = newest_obj(mod = "Question",conditions = [], t_count = "10", unit = "minutes").compact.uniq
      questions.each do |question|
        email_list = %w(305912847@qq.com 1132804655@qq.com)
        email_list.collect{|email| UserMail.send_new_question_notify(email = email, question_id = question.id ).deliver if email.present? and question.present?}
      end
      #UserMail.send_new_question_notify(email = "864248765@qq.com", question_id = Question.last.id ).deliver
    end
    
    desc "pick up user and send a mail about user_birthday_notify"
    task :user_birthday_notify => :environment do
      #for test
      puts "bein to pick up user and send a mail about user_birthday_notify ..."
      #pre_birthday_users.collect{|p| puts "send mail to profile #{p}";UserMail.send("user_birthday_notify",p) if Profile.exists? p}
      pre_birthday_users.collect{|p| puts "send mail to profile #{p}";UserMail.send("user_birthday_notify",p).deliver if Profile.exists? p}
    end
    
    desc "pick up baby and send a mail about baby_birthday_notify"
    task :baby_birthday_notify => :environment do
      #for test
      puts "bein to pick up baby and send a mail about baby_birthday_notify ..."
      #pre_baby_birthday_users.collect{|b| puts "send mail to baby #{b}";UserMail.send("baby_birthday_notify",b) if Baby.exists? b}
      pre_baby_birthday_users.collect{|b| puts "send mail to profile #{p}";UserMail.send("baby_birthday_notify",b).deliver if Baby.exists? b}
    end
    
    #RAILS_ENV=production rake bbtangcms:notify:weekly_notify["1"]
    desc "pick up baby and send a mail about weekly_notify"
    task :weekly_notify, [:week_count] => [:environment] do |t, args|
      #args.with_defaults(:file => "tmp/goods/test.csv")
      template_path = "tmp/newsletter/"
      template_name = "week#{args.week_count}.html"
      template_full_path = "#{Rails.root}/#{template_path}#{template_name}"

      puts "send a mail about #{args.week_count} weekly_notify to #{args.email} ..."
      if File.exists? (template_full_path) and args.week_count.present?
        puts "get file #{template_full_path}"
        pick_user_and_send_mail(type="weekly",options =  {"template_name" => template_name, "template_path" => template_path} )
      end
    end
    
    #scp -r tmp/newsletter/ bbt@bbtang.com:~/bbtang/bbtcms/current/tmp/newsletter/
    #RAILS_ENV=development rake bbtangcms:notify:weekly_notify_test["1","864248765@qq.com"]
    #RAILS_ENV=production rake bbtangcms:notify:weekly_notify_test["1"]
    desc "test task for send weekly_notify"
    task :weekly_notify_test, [:week_count,:email] => [:environment] do |t, args|
      #args.with_defaults(:file => "tmp/goods/test.csv")
      args.with_defaults(:email => "snail_zhu@bbtang.com")
      template_path = "tmp/newsletter/"
      template_name = "week#{args.week_count}.html"
      template_full_path = "#{Rails.root}/#{template_path}#{template_name}"

      puts "send a mail about #{args.week_count} weekly_notify to #{args.email} ..."
      if template_path.present? and (File.exists? (template_full_path)) and args.email.present?
        puts "get file #{template_full_path}"
        UserMail.send("weekly_notify",args.email,options = {"template_name" => template_name, "template_path" => template_path}).deliver
      end
    end

    #scp -r tmp/newsletter/ bbt@bbtang.com:~/bbtang/bbtcms/current/tmp/newsletter/
    #RAILS_ENV=development rake bbtangcms:notify:weekly_notify_special_user["1","864248765@qq.com"]
    #RAILS_ENV=production rake bbtangcms:notify:weekly_notify_special_user["1","gushanrong@yahoo.com.cn"]
    desc "weekly_notify to special users,which begin from one user_id ..."
    task :weekly_notify_special_user, [:week_count,:email] => [:environment] do |t, args|
      #args.with_defaults(:file => "tmp/goods/test.csv")
      args.with_defaults(:email => "")
      template_path = "tmp/newsletter/"
      template_name = "week#{args.week_count}.html"
      template_full_path = "#{Rails.root}/#{template_path}#{template_name}"
      
      puts "send a mail about #{args.week_count} weekly_notify to users,which begin from one user_id ..."
      if (File.exists? (template_full_path)) and args.email.present?
        puts "get file #{template_full_path}"
        s_user = User.find_by_email args.email.strip
        
        if s_user.present?
          #users = User.where(id: s_user.id ..(s_user.id + 500))
          users = User.where("id >= #{s_user.id}").limit(250)
          options = {"template_name" => template_name, "template_path" => template_path}
          
          if Rails.env.production?
            puts "send mail to ..."
            users.collect{|u| UserMail.send("weekly_notify",u.email,options = options).deliver}
          else
            puts "pick user: \n#{users.join(",")}\nTotal: #{users.count}"
          end

        end
      end
    end
    
    #scp -r tmp/newsletter/ bbt@bbtang.com:~/bbtang/bbtcms/current/tmp/newsletter/
    #RAILS_ENV=development rake bbtangcms:notify:weekly_notify_special_user_no_mmbk["1","864248765@qq.com"]
    #RAILS_ENV=production rake bbtangcms:notify:weekly_notify_special_user_no_mmbk["1","gushanrong@yahoo.com.cn"]
    desc "weekly_notify to special users,which begin from one user_id and not from mmbkoo ..."
    task :weekly_notify_special_user_no_mmbk, [:week_count,:email] => [:environment] do |t, args|
      #args.with_defaults(:file => "tmp/goods/test.csv")
      args.with_defaults(:email => "")
      template_path = "tmp/newsletter/"
      template_name = "week#{args.week_count}.html"
      template_full_path = "#{Rails.root}/#{template_path}#{template_name}"
      
      puts "send a mail about #{args.week_count} weekly_notify to users,which begin from one user_id ..."
      if (File.exists? (template_full_path)) and args.email.present?
        puts "get file #{template_full_path}"
        s_user = User.find_by_email args.email.strip
        
        if s_user.present?
          #users = User.where(id: s_user.id ..(s_user.id + 250))
	  #这个查找出来的只有有authorizations关联的用户
          users = User.joins(:authorizations).where("authorizations.provider='mmbkoo' and users.id >= #{s_user.id}").limit(250)

          #这里查找的就是所有非mmbk用户并且id大于s_user的id的5个用户
          users = User.where("id >= #{s_user.id} and id NOT IN (SELECT authorizations.user_id FROM authorizations WHERE (provider = 'mmbkoo'))").limit(250)
          
          options = {"template_name" => template_name, "template_path" => template_path}
          
          if Rails.env.production?
            puts "send mail to ..."
            users.collect{|u| UserMail.send("weekly_notify",u.email,options = options).deliver}
          else
            puts "pick user: \n#{users.join(",")}\nTotal: #{users.count}"
          end

        end
      end
    end

    desc "pick up user and send a mail about monthly_notify"
    task :monthly_notify => :environment do
      puts "bein to pick up user and send a mail about monthly_notify ..."
      pick_user_and_send_mail(type="monthly")
    end
    
    desc "pick up user and send a mail about festival_notify"
    task :festival_notify => :environment do
      puts "bein to pick up user and send a mail about festival_notify ..."
      pick_user_and_send_mail(type="festival",{festival: "abc"})
    end
  end
end
