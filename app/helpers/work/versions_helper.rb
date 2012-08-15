module Work::VersionsHelper
  def version_params(hash={})
    hash.delete_if {|key, value| !(Version.column_names.include? key.to_s) }
    Hash[:version, hash]
  end
  def filter_drop_down_li(obj = "Version", col = '',count = 20)
    obj = obj.classify.constantize
    #Version.all.collect{|v| ["#{v.item}",v.item_id]}.uniq
    if obj.column_names.include? col.to_s
      head = "<ul class='nav nav-pills'><li class='dropdown'><a class='dropdown-toggle' data-toggle='dropdown' href='#menu1'>#{obj.human_attribute_name(col.to_sym)}<b class='caret'></b></a><ul class='dropdown-menu'>"
      list = obj.find(:all, :order => "id desc").collect{|v| ["#{v.send(col.to_sym)}",v.send(col.to_sym)]}
      #list = obj.find(:all, :order => "id desc", :limit => count).collect{|v| ["#{v.send(col.to_sym).to_date}",v.send(col.to_sym).to_date]}.uniq
      if col.eql? "created_at"
        list = obj.find(:all, :order => "id desc").collect{|v| ["#{v.send(col.to_sym).to_date}",v.send(col.to_sym).to_date]}
      end
      if col.eql? "whodunnit"
        list = obj.find(:all, :order => "id desc").collect{|v| ["#{find_user(v.send(col.to_sym))}",v.send(col.to_sym)]}
      end
      if col.eql? "item_id"
        list = obj.find(:all, :order => "id desc").collect{|v| ["#{(v.send(col.gsub("_id",'').to_sym))}",v.send(col.to_sym)]}
      end
      if col.eql? "item_type"
        list = obj.find(:all, :order => "id desc").collect{|v| ["#{v.send(col.to_sym).classify.constantize.model_name.human.pluralize}",v.send(col.to_sym)]}
      end
      content = list.uniq[0 .. count-1].collect{|l| raw "<li>#{link_to l[0],work_versions_path(version_params({col.to_sym =>l[1]})) }</li>"}.join
      foot = "</ul></li>"
      return raw "#{head + content + foot}"
    end
  end
end
