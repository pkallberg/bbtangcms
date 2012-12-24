module Admin::AdminBaseHelper
  def all_setting_subjects
    Admin::AdminBaseController::SettingSubject
  end
  
  def all_setting_types
    Admin::AdminBaseController::SettingType
  end
  
  def all_subject_types
    Admin::AdminBaseController::SubjectType
  end
  
  def find_setting_by_type(type = nil)
    if type.present? and type.is_a?(Fixnum)
      Hash[all_setting_types[type], all_setting_subjects.select{|k,v| v.eql? type}]
    end
  end
end
