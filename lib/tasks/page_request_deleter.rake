namespace 'bbtangcms' do
  namespace 'page_request' do
    desc "Cleans out record older than 7 days"
    task :clean_older => :environment do
      #PageRequest.all.limit(count).entries.count if (count = PageRequest.count-1000) > 0
      #PageRequest.where(:created_at.gt => Time.now - 7.days.ago).count
      #PageRequest.where(:created_at.gte =>  1.year.ago, :created_at.lte => 7.days.ago).count
      PageRequest.where(:created_at.gte => 1.year.ago, :created_at.lte => 1.day.ago).collect{|p| p.destroy }
    end
  end
end
