# coding: utf-8
module CommonHelper
  def model_columns_collection(model_class = nil, whitelist = false,except =[] )
    if (model_class.method_defined? :columns) or (model_class.respond_to? :columns)
      if whitelist
      #model_class.columns.collect{|column| [model_class.human_attribute_name(column.name),column.name]}
      #model_class.attribute_names.collect{|column| [model_class.human_attribute_name(column),column]}
        model_columns_list = model_class.accessible_attributes.collect{|column| [model_class.human_attribute_name(column),column]}
      else
        model_columns_list = model_class.column_names.collect{|column| [model_class.human_attribute_name(column),column]}
      end

    else
      if (model_class.method_defined? :fields) or (model_class.respond_to? :fields)
      model_columns_list = model_class.fields.to_a.collect{|field| [model_class.human_attribute_name(field.first),field.first]}
      end
    end
    if (except.class == Array) and except.present?
      #model_columns_list.collect!
      model_columns_list.collect!{|col| col unless except.include? col[1]}
    end
    return model_columns_list
  end

  def version_log( t_count = "1", unit = "minute" )
    #h ||= 1
    s_time = t_count.to_i.send(unit).send("ago") if t_count.to_i > 0
    s_time ||= 1.minute.ago
    lastest_logs = Version.where(:created_at => s_time .. Date.tomorrow)
    #count.to_i.send("hours").send("ago") if count.to_i > 0

    lastest_logs.collect{|l| "#{distance_of_time_in_words_to_now(l.created_at,  include_seconds = true)} #{l.whodoit}," + I18n.t("helpers.events.#{l.event}") + "#{l.item_type.classify.constantize.model_name.human.pluralize}" + "'#{l.item}'"}
  end

  def newest_obj(mod = "",conditions = [], t_count = "1", unit = "minute")
    #User.where("id != ?", exclude_ids)
    if mod.present?
      mod = mod.classify.constantize if mod.class == String
      s_time = t_count.to_i.send(unit).send("ago") if t_count.to_i > 0
      s_time ||= 1.minute.ago
      mod_list = mod.where(conditions)
      mod_list.where(:created_at => s_time .. Date.tomorrow) if mod_list.present?
    end
  end

  def obj_range(mod="",s_time = nil,e_time = nil)
    if mod.present? and s_time.present?
      mod = mod.classify.constantize if mod.class == String
      e_time ||= Date.tomorrow
      mod.where(:created_at => s_time .. e_time)
    else
      []
    end
  end

  def obj_range_count(mod="",s_time = nil,e_time = nil)
    obj_range(mod,s_time,e_time).count
  end
  
  def mod_newest_count(mod="")
    if mod.present?
      mod = mod.classify.constantize if mod.class == String
      [1.days.ago, 2.days.ago, 3.days.ago, 1.weeks.ago, 1.month.ago,3.month.ago].collect{|s_t| [s_t, mod.where(:created_at => s_t .. DateTime.now).count]}
    end
  end
  
  def user_newest_count
    regist_sources = ["sina", "tqq", "qq_connect", "mmbkoo"] << "straight"
    [1.days.ago, 2.days.ago, 3.days.ago, 1.weeks.ago, 1.month.ago,3.month.ago].collect{|s_t| [s_t, User.where(:created_at => s_t .. DateTime.now).count, regist_sources.collect{|source| {source => User.where(:created_at => s_t .. DateTime.now).send("#{source}_user_ids").count}}]}
  end
  
  #mod = "user" , unit inside %w(day month year week)
  def obj_group_by_time(mod = "",unit= nil)
    unit ||= "day"
    can_units = %w(day month year week)
    if mod.present? and mod.classify.class_exists? and (can_units.include? unit)
      mod = mod.classify.constantize if mod.class == String
      mod.all.group_by{|u| u.created_at.send("beginning_of_#{unit}")}
    else
      []
    end
  end

  def obj_group_by_time_count(mod="",unit= "day")
    obj_group_by_time(mod,unit).collect{|u| [u.first,u[1].count]}
  end

  def obj_group_by_time_summary(mod = "",unit = "day", format = "short" )
    objs = obj_group_by_time_count(mod,unit)
    if objs.present?
      objs.collect{|u| [time_tag(u[0].to_date,:format=> format.to_sym),u[1]] }
    end
  end

  def obj_tips(obj_list=[])
    if obj_list.present?
      #[Knowledge,Question].collect{|m| m.send(:last).send(:created_user)}

      obj_list.collect{|obj| "#{timeago_tag_content(obj.created_at)} #{obj.send(:created_user)}," + I18n.t("helpers.events.create") + "#{obj.class.model_name.human.pluralize}" + "'#{obj}'"}
    else
      puts "no obj get ..."
    end
  end

  def lastest_logs
    logs = version_log.present? ? version_log : []
    # User.where(" id IN (?) ",User.internal_user_ids).count
    ids = User.internal_user_ids
    questions = newest_obj(mod="Question",conditions= [" created_by NOT IN (?) ",ids])
    question_logs = obj_tips(questions) if questions.present?
    logs.concat(question_logs) if question_logs.present?
    logs
  end

  def get_tag_list_path(tag = nil )
    if tag.present?
      if tag.class == Category
        return link_to tag, tag_identity_timeline_category_path(tag.parent.parent,tag.parent,tag)
      end
      if tag.class == Timeline
        return link_to tag, tag_identity_timeline_categories_path(tag.parent,tag)
      end
      if tag.class == Identity
        return link_to tag, tag_identity_timelines_path(tag)
      end
    end
  end

  def find_user(id = nil, email = nil, username = nil)
    u = (User.where id: id).first if id.present?
    u = (User.where email: email).first if email.present?
    u = (User.where username: username).first if username.present?
    u
  end

  def object_summary(obj = nil, column = "", length = 50)
    summary_fields = [:title ,:summary, :label, :content, :body].collect{|c| c.to_s}
    if obj.present?
      obj_class = obj.class
      if obj_class.respond_to? :columns_hash
        str_columns = obj_class.columns_hash.collect{|key,value| key if [:text, :string].include? value.type }.compact

        summary_fields = str_columns & summary_fields
      end
    end
    unless column.present?
      #column = summary_fields.first
      column = summary_fields.collect{|f| f if obj.respond_to? f.to_sym}.compact.first
    end
    if column.present? and obj.send(column).present?
      truncate(obj.send(column), :length => length)
    else
      "#{obj}"
    end
  end

  def change_ip_to_city(ip=nil)
    is = IpSearch.new
    ip ||= "116.228.214.170"
    is.find_ip_location(ip)
    #breakpoint
    #return is.country.gsub("市","")
    is.country.split("省").last.gsub("市","")
  end
  def obj_conditions_params(obj = "Version", hash={}, hash_name = "conditions")
    obj = obj.classify.constantize
    hash.delete_if {|key, value| !(obj.column_names.include? key.to_s) }
    {hash_name => hash}.to_param
  end

  def obj_params(obj = "Version", hash={})
    obj = obj.classify.constantize
    hash.delete_if {|key, value| !(obj.column_names.include? key.to_s) }
    hash.to_param
  end

  def obj_filter_drop_down_li(obj = "Version", col = '' ,path = nil,count = 20)
    obj_class = obj.classify.constantize
    if obj_class.column_names.include? col.to_s
      head = "<ul class='nav nav-pills'><li class='dropdown'><a class='dropdown-toggle' data-toggle='dropdown' href='#menu1'>#{obj_class.human_attribute_name(col.gsub("_id",'').to_sym)}<b class='caret'></b></a><ul class='dropdown-menu'>"
      list = obj_class.order("id desc").group(col.to_sym).uniq.delete_if{|item| item.send(col).nil?}.collect{|item| ["#{item.send((col.gsub("_id",'')))}",item.send(col)]}
      if col.end_with? "_by"
        #list = obj.find(:all, :order => "id desc").collect{|v| ["#{(v.send(col.gsub("_id",'').to_sym))}",v.send(col.to_sym)]}
        #list = obj.select([col.to_sym,:id]).collect{|item| ["#{item.reload.send(col.gsub("_id",''))}",item.send(col)]}.uniq
        list = obj_class.order("id desc").group(col.to_sym).uniq.delete_if{|item| item.send(col).nil?}.collect{|item| ["#{item.send(col.gsub("_by",'_user'))}",item.send(col)]}.uniq
      end
      path ||= self.send("#{obj.pluralize.downcase}_path")

      content = list[ 0 .. (count.to_i - 1)].collect{|l| raw "<li>#{link_to l[0],(path +"/?" + obj_conditions_params(obj = obj,{col.to_sym =>l[1]})) }</li>"}.join
      foot = "</ul></li>"
      return raw "#{head + content + foot}"
    end
  end
end
