# encoding: utf-8
module Work::DashboardHelper
  def item_list_who_change(item_type = nil,user = nil,start_time = Date.today, end_time = Date.tomorrow)
    user ||= current_user if current_user.present?

    Version.where(item_type: item_type.to_s, whodunnit: user.id, created_at: start_time .. end_time)
  end
  def today_work_summary(item_type_list = [] , user = nil)
    user ||= current_user if current_user.present?

    item_type_list ||= Setting.version_mod.split(' ') if Setting.worked_mod.present?
    item_summary_list = []
    item_type_list.each do |item_type|

       item_list = item_list_who_change(item_type = item_type, user = user )
       events = item_events(item_list= item_list)
       item_summary_list.append("On #{item_type.classify.constantize.model_name.human.pluralize} 总共 #{events.count} 事件, 其中 " + events.collect{|e| "#{e[1]}次" +I18n.t("helpers.events.#{e[0]}")}.join(",")) if events.present?
    end
    if item_summary_list.present?
      raw(item_summary_list.join("; ") << " " << (link_to "我的工作日志",work_versions_path(version_params({:whodunnit =>current_user.id})))) << "."
    else
      "No thing logged, today!"
    end
  end

  def item_events(item_list= [])
    item_list.map(&:event).group_by{|i| i}.map{|k,v| [k,v.length]}
  end
end
