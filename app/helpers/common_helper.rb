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

  def lastest_log( count = "1", unit = "minute" )
    #h ||= 1
    s_time = count.to_i.send(unit).send("ago") if count.to_i > 0
    s_time ||= 1.minute.ago
    lastest_logs = Version.where(:created_at => s_time .. Date.tomorrow)
    #count.to_i.send("hours").send("ago") if count.to_i > 0

    lastest_logs.collect{|l| "#{time_tag l.created_at, :format => :short} #{l.whodoit}," + I18n.t("helpers.events.#{l.event}") + "#{l.item_type.classify.constantize.model_name.human.pluralize}" + "'#{l.item}'"}
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

  def change_ip_to_city(ip=nil)
    is = IpSearch.new
    ip ||= "116.228.214.170"
    is.find_ip_location(ip)
    #breakpoint
    return is.country.first.gsub("市","")
  end
end
