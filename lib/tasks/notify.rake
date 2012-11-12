def newest_obj(mod = "",conditions = [], t_count = "1", unit = "hours")
  #User.where("id != ?", exclude_ids)
  if mod.present?
    mod = mod.classify.constantize if mod.class == String
    s_time = t_count.to_i.send(unit).send("ago") if t_count.to_i > 0
    s_time ||= 1.hours.ago
    mod_list = mod.where(conditions)
    if mod_list.present?
      mod_list.where(:created_at => s_time .. DateTime.now)
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

def pick_user_and_send_mail(type = "",festival = nil)
  # Profile.where("age > 21").find_in_batches
  User.joins(:profile).find_in_batches(:batch_size => 500) do |items|
    sleep(50) # Make sure it doesn't get too crowded in there!
    #items.collect{|item| [item.email,item.profile.notify_via_email]}
    items.each do |item|
      #UserMail.send("#{type}_notify",item.email,festival).deliver if item.profile.notify_via_email.present?
      puts "send mail to #{item}"
      UserMail.send("#{type}_notify",item.email,festival).deliver
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
    desc "pick up baby and send a mail about baby_birthday_notify"
    task :weekly_notify => :environment do
      puts "bein to pick up user and send a mail about weekly_notify ..."
      pick_user_and_send_mail(type="weekly")
    end
    desc "pick up user and send a mail about monthly_notify"
    task :monthly_notify => :environment do
      puts "bein to pick up user and send a mail about monthly_notify ..."
      pick_user_and_send_mail(type="monthly")
    end
    desc "pick up user and send a mail about festival_notify"
    task :festival_notify => :environment do
      puts "bein to pick up user and send a mail about festival_notify ..."
      pick_user_and_send_mail(type="festival",festival = "abc")
    end
  end
end
