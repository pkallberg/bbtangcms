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

    lastest_logs.collect{|l| "#{time_tag l.created_at, :format => :short} #{l.whodoit}," + I18n.t("helpers.events.#{l.event}") + "#{l.item_type.classify.constantize.model_name.human.pluralize}" + "'#{l.item}'"}
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

  def obj_tips(obj_list=[])
    if obj_list.present?
      #[Knowledge,Question].collect{|m| m.send(:last).send(:created_user)}

      obj_list.collect{|obj| "#{time_tag obj.created_at, :format => :short} #{obj.send(:created_user)}," + I18n.t("helpers.events.create") + "#{obj.class.model_name.human.pluralize}" + "'#{obj}'"}
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
    summary_fields = [:title ,:summary, :label, :body].collect{|c| c.to_s}
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
    return is.country.first.gsub("市","")
  end
end
