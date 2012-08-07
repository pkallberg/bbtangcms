module Work::DashboardsHelper
  def item_list_who_change(item_type = nil,user = nil,start_time = Date.today, end_time = Date.tomorrow)
    if current_user.present?
      user ||= current_user
    end
    Version.where(item_type: item_type.to_s, whodunnit: user.id, created_at: start_time .. end_time)
  end
  def today_work_summary(item_type_list = [] , user = nil)
    user ||= current_user if current_user.present?
    item_type_list ||= Setting.version_mod.split(' ') if Setting.worked_mod.present?
    item_summary_list = []
    item_type_list.each do |item_type|
       item_list = item_list_who_change(item_type = item_type)
       events = item_events(item_list= item_list)
       item_summary_list.append("On #{item_type.classify.constantize.model_name.human.pluralize}, "+events.collect{|e| "#{e[0]}(#{e[1]})"}.join(",")) if events.present?
    end
    item_summary
  end

  def item_events(item_list= [])
    item_list.map(&:event).group_by{|i| i}.map{|k,v| [k,v.length]}
  end
end
