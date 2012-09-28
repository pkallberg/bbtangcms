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

namespace 'bbtangcms' do
  namespace 'notify' do
    desc "pick up questions inside a time range and send a mail"
    task :new_question_notify => :environment do
      #questions = newest_obj(mod = "Question", t_count = "10", unit = "minutes").compact.uniq#params picked follw queue order when method defined
      questions = newest_obj(mod = "Question",conditions = [], t_count = "10", unit = "minutes").compact.uniq
      questions.each do |question|
        #UserMail.send_new_question_notify(email = "305912847@qq.com", question_id = question.id ).deliver! if question.present?
      end
      UserMail.send_new_question_notify(email = "864248765@qq.com", question_id = Question.last.id ).deliver!
    end
  end
end
