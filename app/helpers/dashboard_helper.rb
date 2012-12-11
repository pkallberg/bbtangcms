# coding: utf-8
module DashboardHelper
  def user_welcome(params={})
    user = params.delete(:user)
    user ||= current_user
    if user.present?
      #raw I18n.t("helpers.dashboard.user_welcome", cms_roles: user.cms_roles.uniq.compact.collect{|c| "#{c}"}.join(","), user: "#{user}", current_sign_in_at: "#{timeago_tag user.current_sign_in_at}", current_sign_in_city: "#{user.current_sign_in_city}")
      raw I18n.t("helpers.dashboard.user_welcome", cms_roles: "", user: "#{user}", last_sign_in_at: "#{timeago_tag user.last_sign_in_at}", last_sign_in_city: "#{user.last_sign_in_city}", current_sign_in_city: "#{user.current_sign_in_city}")
    end
  end

  def focus_recommendation_slide(params = {})
    position = params.delete(:position) if params[:position].present?
    position ||= "root_focus"
    focus_recommendations = Recommend::RecommendOther.where(:recommend_other_type => "focus_recommendation").entries
    focus_recommendations.collect{|focus_recommendation| focus_recommendation if focus_recommendation["position"].include? position}.compact
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
    if Rails.cache.read("users_summary_cache").nil?
      users_summary_cache = "社区会员: #{User.count} 人, #{user_level_summary}"
      Rails.cache.write("users_summary_cache" ,users_summary_cache , :expires_in => 30.minutes)
    end
    Rails.cache.read("users_summary_cache")
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
    #s_time ||= 1.day.ago
    s_time ||= DateTime.now.midnight
    users = User.includes(:profile).where(:created_at => s_time .. DateTime.now).order("id desc")
    
    if Rails.cache.read("newest_users_cache").nil?
      newest_users_cache = users
      Rails.cache.write("newest_users_cache" ,newest_users_cache , :expires_in => 30.minutes)
    end
    Rails.cache.read("newest_users_cache")
  end
end 
