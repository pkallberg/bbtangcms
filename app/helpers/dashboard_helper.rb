# coding: utf-8
module DashboardHelper
  def users_summary
    "社区会员: #{User.count} 人"
  end

  def newest_users( count = "1", unit = "day" )
    s_time = count.to_i.send(unit).send("ago") if count.to_i > 0
    s_time ||= 1.day.ago
    users= User.where(:created_at => s_time .. Date.tomorrow)
  end
end
