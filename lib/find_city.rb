require 'json'

class FindCity

  #attr_accessor :meth # for getter and setters
  #attr_writer :meth # for setters
  #attr_reader :meth # for getters

  attr_reader :cityhash,:municipality

  if not File.exists?('lib/city.json')
    puts 'city.json not exists download for sina ...'
    `curl http://api.t.sina.com.cn/provinces.json > lib/city.json`
  end
  CityHash = JSON.parse File.read('lib/city.json')


  def initialize
    @cityhash=CityHash
    @municipality=[31,11,12,50,81,82]
  end

  def get_all_city
    cityhash=@cityhash
    cityhash["provinces"].each do |provinces|
      if @municipality.include? provinces["id"].to_i
        provinces.delete("citys")
      end
    end

    return cityhash["provinces"]
  end

  def getcity(province_id=nil, city_id=nil)
    province_id=province_id.to_i
    city_id=city_id.to_i
    if @municipality.include? province_id
      @cityhash["provinces"].each do |provinces|
        if provinces["id"] == province_id
          return provinces["name"]
        end
      end
    else
      @cityhash["provinces"].each do |provinces|
        if provinces["id"] == province_id
          provinces["citys"].each do |city|
            return city[city_id.to_s] if city[city_id.to_s]
          end
        end
      end
    end
    return nil
  end
end

if __FILE__==$0
  #************************以下测试代码*****************
  time_start = Time.now
  city = FindCity.new
  list=[[6,2],[11,1],[43,2]]

  list.each do |l|
    puts city.getcity l[0],l[1]
  end

  puts city.get_all_city

  puts "total time:#{Time.now-time_start}"
end
