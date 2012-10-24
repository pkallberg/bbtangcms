module Work::VersionsHelper
  def version_params(hash={})
    hash.delete_if {|key, value| !(Version.column_names.include? key.to_s) }
    Hash[:version, hash]
  end
  def version_filter_drop_down_li(obj = "Version", col = '',count = 20, max_count = 5000)
    obj = obj.classify.constantize
    #Version.all.collect{|v| ["#{v.item}",v.item_id]}.uniq
    if obj.column_names.include? col.to_s
      head = "<ul class='nav nav-pills'><li class='dropdown'><a class='dropdown-toggle' data-toggle='dropdown' href='#menu1'>#{obj.human_attribute_name(col.to_sym)}<b class='caret'></b></a><ul class='dropdown-menu'>"
      #list = obj.find(:all, :order => "id desc").collect{|v| ["#{v.send(col.to_sym)}",v.send(col.to_sym)]}
      list = obj.order("id desc").select(col.to_sym).uniq.limit(max_count).delete_if{|item| item.send(col).nil?}.collect{|item| ["#{item.send(col)}",item.send(col)]}.uniq
      #list = obj.find(:all, :order => "id desc", :limit => count).collect{|v| ["#{v.send(col.to_sym).to_date}",v.send(col.to_sym).to_date]}.uniq
      if col.eql? "created_at"
        #list = obj.find(:all, :order => "id desc").collect{|v| ["#{v.send(col.to_sym).to_date}",v.send(col.to_sym).to_date]}
        list =obj.order("id desc").select(col.to_sym).uniq.limit(max_count).delete_if{|item| item.send(col).nil?}.collect{|item| ["#{item.send(col).to_date}",item.send(col).to_date]}.uniq
      end
      if col.eql? "whodunnit"
        #list = obj.find(:all, :order => "id desc").collect{|v| ["#{find_user(v.send(col.to_sym))}",v.send(col.to_sym)]}
        list = obj.order("id desc").select(col.to_sym).uniq.limit(max_count).delete_if{|item| item.send(col).nil?}.collect{|item| ["#{find_user(item.send(col))}",item.send(col)]}.uniq
      end
      if col.eql? "item_id"
        #list = obj.find(:all, :order => "id desc").collect{|v| ["#{(v.send(col.gsub("_id",'').to_sym))}",v.send(col.to_sym)]}
        #list = obj.select([col.to_sym,:id]).collect{|item| ["#{item.reload.send(col.gsub("_id",''))}",item.send(col)]}.uniq
        list = obj.order("id desc").group(col.to_sym).uniq.limit(max_count).collect{|item| ["#{item.send(col.gsub("_id",''))}",item.send(col)]}.uniq
      end
      if col.eql? "item_type"
        #list = obj.find(:all, :order => "id desc").collect{|v| ["#{v.send(col.to_sym).classify.constantize.model_name.human.pluralize}",v.send(col.to_sym)]}
        list = obj.order("id desc").group(col.to_sym).uniq.limit(max_count).collect{|item| ["#{item.send(col).classify.constantize.model_name.human.pluralize}",item.send(col)]}.uniq
      end
      content = list[0..count].collect{|l| raw "<li>#{link_to l[0],work_versions_path(version_params({col.to_sym =>l[1]})) }</li>"}.join
      foot = "</ul></li>"
      return raw "#{head + content + foot}"
    end
  end
end
