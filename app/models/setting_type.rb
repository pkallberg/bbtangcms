# coding: utf-8
class SettingType < ActiveRecord::Base
  has_many :setting_subjects
end
