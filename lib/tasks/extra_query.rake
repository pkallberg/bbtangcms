include ActionView::Helpers::DateHelper
def notes_from_level(level_id = level_id)
  level_id = level_id.to_i
  if level_id.eql? 1
    notes = (Profile.level(1) + Profile.level(nil)).collect{|p| ["#{p}",Note.where(created_by: p.user_id).count]}.delete_if{|item| item.last.eql? 0}
  else
    notes = Profile.level(level_id.to_i).collect{|p| ["#{p}",Note.where(created_by: p.user_id).count]}
  end
end

namespace 'bbtangcms' do
  namespace 'extra_query' do
  
    desc "note created by level_id (eg,level_id = 3(expert)) ...,some user no note will be skiped"
    task :notes_from_level_id, [:level_id, :detail] => [:environment] do |t, args|
      args.with_defaults(level_id: 2, detail: "true")
      level_id = args.level_id.to_i
      detail = (args.detail.eql? "true") ? true : false
      
      notes = notes_from_level(level_id)
      puts "bein to pick up user's notes which level_id = #{level_id} ...,some user no note will be skiped."
      
      if detail
        puts notes.collect{|item| item.first.ljust(50) << item.last.to_s  if item.present?}.join("\n")
      end
      
      puts "all in total:" << "#{notes.collect{|item| item.last if item.present?}.compact.sum}"
    end
    
    desc "pick up Model's tagclound (eg,model_class_name = 'Knowledge', tag_context = 'timelines' ..."
    task :model_tagclound, [:model_class_name, :tag_context, :detail] => [:environment] do |t, args|
      args.with_defaults(model_class_name: "Knowledge",tag_context: "timelines", detail: "true")
      model_class = args.model_class_name.classify.constantize if args.model_class_name.class_exists?
      detail = (args.detail.eql? "true") ? true : false
      
      
      if model_class.present?
        tag_clound = model_class.tag_counts_on(args.tag_context.to_sym)
        
        if detail
          puts tag_clound.collect{|tag| tag.name.ljust(50) << tag.count.to_s}
        end
        
        puts "all in total:" << "#{tag_clound.collect{|item| item.count}.compact.sum}"
      else
        puts "no model named #{args.model_class_name}"
      end
    end
    
    desc "all user summary ... "
    task :user_summary => [:environment] do |t, args|
      #Authorization.pluck(:provider).uniq.collect{|provider| Authorization.where(:provider => provider ).count}
      puts "all user summary group by sign_up source ... "
      count_collection = Authorization.group(:provider).count
      all_users_count = User.all.count
      straight_users_count = all_users_count - User.joins(:authorizations).count
      count_collection.merge! "all" => all_users_count, "straight" => straight_users_count
      puts "until now we has:#{count_collection}"
    end
    
    desc "users sign_in activity ... "
    task :user_sign_in_activity => [:environment] do |t, args|
      #Authorization.pluck(:provider).uniq.collect{|provider| Authorization.where(:provider => provider ).count}
      puts "users sign_in activity, pick up count of user whose last_sign_in_at special time range"
      time_range = [1.days.ago, 2.days.ago, 3.days.ago, 5.days.ago, 1.weeks.ago, 1.month.ago, 2.month.ago, 3.month.ago]
      count_collection = time_range.collect{|time| [time_ago_in_words(time),User.where(last_sign_in_at: [time..DateTime.now]).count]}
      puts "until now we has:\n" << count_collection.collect{|item| (item.first << " ago:").ljust(30)  << item.last.to_s}.join("\n")
    end
    
    desc "rum some task together ... "
    task :run_simply, [:detail]=> [:environment] do |t, args|
      args.with_defaults(detail: "false")
      detail = (args.detail.eql? "true") ? "true" : "false"
      puts "begin some task inside extra_query.rake ... "
      task_list = [ 
        ["user_summary", []],
        ["user_sign_in_activity", []],
        ["model_tagclound", ["knowledge", "categories", detail]],
        ["model_tagclound", ["knowledge", "categories", detail]],
        ["model_tagclound", ["knowledge", "tags", detail]],
        #["notes_from_level_id", []],
        ["notes_from_level_id", [1]],
        ["notes_from_level_id", [2]],
        ["notes_from_level_id", [3]]
      ]

      task_list.each do |task_opt|
        task = task_opt.first
        opt = task_opt.last
        puts "#" * 80
        puts "begin task #{task} ..."
        #Reenable the task, allowing its tasks to be executed if the task is invoked again.
        Rake::Task["bbtangcms:extra_query:#{task.to_s}"].reenable
        Rake.application.invoke_task("bbtangcms:extra_query:#{task.to_s}[#{opt.join(',')}]")
        #not work
        #Rake::Task["bbtangcms:extra_query:#{task.to_s}"].invoke(opt)
        sleep(5) if Rails.env.production?
      end
    end
  end
end
=begin
task :invoke_my_task do
  Rake.application.invoke_task("my_task[1, 2]")
end

# or if you prefer this syntax...
task :invoke_my_task_2 do
  Rake::Task[:my_task].invoke(3, 4)
end
=end
