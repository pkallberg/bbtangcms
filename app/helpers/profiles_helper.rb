# -*- Encoding: utf-8 -*-
module ProfilesHelper
  def get_face_url(profile= nil, options = {})
    #breakpoint
    local_face = options[:local_face] || false
    size = options[:size].to_s || "s120"
    if profile.present?
      if not(local_face) and profile.oauth_face_image_url and not (profile.face?)
        return profile.oauth_face_image_url
      else
        return profile.face.url(size)
      end
    else
      image_path("profile/face/#{size}/missing.png")
    end
  end
  def get_hoter_city
    %w(北京 上海 广州 武汉 成都 深圳 杭州 西安 南京 长沙 郑州 重庆 天津 福州 温州)
  end
  def get_all_city
    fcity=FindCity.new
    cities=fcity.get_all_city
    cities=cities[0..-2]

    cities.each do |province|
      if province.has_key?("citys")
        link_to province,"#",{:title => province}
        province["citys"].each
      else
      end
    end
  end
end
