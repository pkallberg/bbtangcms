require 'csv'
#sources http://rake.rubyforge.org/doc/rakefile_rdoc.html

def load_data(param={})
  file = param.delete(:file)
  #file = "#{Rails.root}/tmp/goods/test.csv" unless file.present?
  #csv = CSV.open(file)
  #JSON.parse csv.to_json
  file = "#{Rails.root}/#{file}" unless file.to_s.start_with? '/'
  if File.exists? file
    csv = CSV.read(file)
  else
    puts "#{file} not exists ..."
  end
end

def update_goods_from_csv(file = nil)
  data = load_data(file: file)
  if data.present?
    #date.shift if date.first.compact.empty?
    puts "remove empty rows ..."
    data.delete_if{|d| d.compact.empty?}
    puts "find goods categories [#{data.shift.join(',')}] ..., then update goods datebase ..."
    data.each do |d|
      if d.first.present?
        #goods = Goods.find_or_create_by_name(d[0])
        goods = Goods.find_or_create_by_url(d[1])
        puts "pick up goods #{goods} ..."
        if goods.present?
          puts "update goods #{goods} ..."
          goods.update_attributes(name: d[0], url: d[1], category_major_list: d[2], category_small_list: d[3], tag_list: d[5])
        end
      else
        puts "skip goods with empty name ..."
      end
    end
  end
end
# rake bbtangcms:db:goods_import["tmp/goods/test.csv"]
namespace 'bbtangcms' do
  namespace 'db' do
    desc "pick up goods from csv file and export to database ..."
    task :goods_import, [:file] => [:environment] do |t, args|
      #args.with_defaults(:file => "tmp/goods/test.csv")
      puts "pick up goods from csv file and export to database ..."
      puts "get file #{args.file}" if args.file.present?
      update_goods_from_csv("#{args.file}")
    end
  end
end
