# coding: utf-8
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

def date_formater(real_format, goods_data)
  except_format = { :name => "产品名称",
                    :url => "产品链接",
                    :tag_list=>"相关标签",
                    :category_list=>"分类标签",
                    :timeline_list=>"适用年龄段",
                    :identity_list=>"对象",
                    :category_major_list=>"产品大类",
                    :category_small_list=>"产品小类",
                    :brand_list=>"品牌"}
  #real_format =  ["产品名称", "产品链接", "品牌", "产品大类", "产品小类", "对象", "适用年龄段", "分类标签", "相关标签"]
  if real_format.present?
    Hash[except_format.collect{|k,v| [k, goods_data[real_format.index(v.to_s)].to_s.split_all] if real_format.include? v.to_s}.compact.uniq]
  else
    {}
  end
end

def update_goods_from_csv(file = nil)
  data = load_data(file: file)
  if data.present?
    #date.shift if date.first.compact.empty?
    puts "remove empty rows ..."
    data.delete_if{|d| d.compact.empty?}
    real_format = data.shift
    puts "find goods categories [#{real_format.join(',')}] ..., then update goods datebase ..."
    total = 0
    data.each do |d|
      if d.first.present?
        #goods = Goods.find_or_create_by_name(d[0])
        goods = Goods.find_or_create_by_url(d[1])
        puts "pick up goods #{goods} ..."
        if goods.present?
          puts "update goods #{goods} ..."
          #goods.update_attributes(name: d[0], url: d[1], category_major_list: d[2], category_small_list: d[3], tag_list: d[5])
          goods_hash = date_formater(real_format, goods_data = d)
=begin
          goods_hash =  { name: d[0],
                          url: d[1],
                          brand_list: d[2],
                          category_major_list: d[3],
                          category_small_list: d[4],
                          identity_list: d[5],
                          timeline_list: d[6],
                          category_list: d[7],
                          tag_list: d[8]}
=end
          puts "update goods's attributes #{goods_hash}"

          if goods_hash.present?
            total += 1
            goods.update_attributes(goods_hash)
          end

        end
      else
        puts "skip goods with empty name ..."
      end
    end
    puts "In total: update #{total} goods."
  end
end
#scp tmp/goods/goods-20121024-summary.csv bbt@bbtang.com:~/bbtang/bbtcms/current/tmp/goods/goods-20121024-summary.csv
#scp -r tmp/goods/ bbt@bbtang.com:~/bbtang/bbtcms/current/tmp/goods/
#RAILS_ENV=production rake bbtangcms:db:goods_import["tmp/goods/goods-2012-11-8.csv"]
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
=begin
all_tags =[:tag_list, :category_list, :timeline_list, :identity_list,\
 :category_major_list, :category_small_list, :brand_list]
all_tags.collect!{|t| t.to_s.gsub("_list",'').pluralize.to_sym}
all_tags.collect{|t| puts Goods.tag_counts_on(t).map(&:name)}
=end
