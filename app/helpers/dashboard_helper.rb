# coding: utf-8
module DashboardHelper
  def focus_recommendation_slide
    Recommend::RecommendOther.where(:recommend_other_type => "focus_recommendation").entries
  end
  def users_group_by_level
    #users_group_level =Level.all.collect{|level| Profile.where(level_id: level.id).delete_if{|profile| profile.user.nil?}}
    #user_with_nil_level = Profile.where(level_id: nil).delete_if{|profile| profile.nil?}
     #users_group_level = Profile.select([:user_id, :nickname, :level_id]).collect{|p| p.level_id.present? ? p : (p.level_id = 1;p)}.group_by(&:level_id)
     users_group_level = profile_group_by_level(Profile.select([:user_id, :nickname, :level_id]))
  end

  def profile_group_by_level(profiles= Profile.limit(50))
    profiles.collect{|p| p.level_id.present? ? p : (p.level_id = 1;p)}.group_by(&:level_id)
  end

  def user_level_summary
    users_group_level = users_group_by_level
    users_group_level.collect{|u| "#{Level.find_by_id u.first} #{u.last.count} 人"}.join(",")
  end

  def users_summary
    "社区会员: #{User.count} 人, #{user_level_summary}"
  end

  def newest_users_summary
    #newest_users = User.limit(50)
    if newest_users.present?
      "最新加入 (#{newest_users.count}) 人, 其中 " + profile_group_by_level(newest_users.delete_if{|u| u.profile.nil?}.collect{|u| u.profile}).collect{|u| "#{Level.find_by_id u.first} #{u.last.count} 人"}.join(",")
    else
      "最新加入 (#{newest_users.count}) 人."
    end
  end

  def newest_users( count = "1", unit = "day" )
    s_time = count.to_i.send(unit).send("ago") if count.to_i > 0
    s_time ||= 1.day.ago
    users= User.includes(:profile).where(:created_at => s_time .. Date.tomorrow)
  end
end 
