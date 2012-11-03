# encoding: utf-8
class MmbkUserExportReporter
  include Mongoid::Document
  include Mongoid::Timestamps
  #before_validation :set_array

  field :plan_count, type: Integer
  field :pick_count, type: Integer
  field :real_count, type: Integer
  field :last_mmbk_user_id, type: Integer


  def last_mmbk_user
    if "MMBKUser".class_exists? and last_mmbk_user_id.present?
      MMBKUser.find_by_user_id last_mmbk_user_id
    end
  end

  def to_s
    "mmbk_user_export_reporter created on #{created_at}" if created_at.present?
  end


end
