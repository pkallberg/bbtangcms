def export_all_knowledge
  cols = [:title, :summary, :content, :tag_list, :identity_list, :timeline_list, :category_list , :created_user, :created_by ]
  old_path = Rails.root.join("tmp/knowledges")
  `rm -rf #{old_path.to_s}`
  Dir.mkdir("tmp/knowledges")
  
  Knowledge.find_in_batches(:batch_size => 500) do  |knowledges|
    knowledges.each do |k|
      cotent_list = cols.collect{|col| "#{k.class.human_attribute_name(col)}: #{k.send(col)}\n"}
      file = File.new("tmp/knowledges/knowledge_#{k.id}.txt", "w")
      file.write(cotent_list.join(''))
      file.close
    end
  end
  `rm #{Rails.root.join('public')}/knowledges_all.tgz` if File.exists? "#{Rails.root.join('public')}/knowledges_all.tgz" 
  `tar -czf #{Rails.root.join('public')}/knowledges_all.tgz #{old_path}`
end
namespace 'bbtangcms' do
  namespace 'knowledge' do
    desc "export all knowledge to *.txt file on tmp/knowledge"
    task :export_all => :environment do
      logger.info "begin to export user in mmbkoo to bbtang ..."
      export_all_knowledge
    end
  end
end
