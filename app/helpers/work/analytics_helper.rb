# coding: utf-8
module Work::AnalyticsHelper
  def model_col_type(model)
    except = ["encrypted_password", "reset_password_token", "confirmation_token", "reuse_token", "unlock_token", 'authentication_token']
    col_types = [:string, :integer, :datetime]
    if model.present?
      model.columns_hash.collect{|c| [c[0],c[1].type] if !(except.include? c[0]) and col_types.include? c[1].type}.compact.uniq
    end
  end
  
  #col_select(:string, position = "end")
  def col_select(type, position = "begin")
    type ||= :string
    case type.to_sym
    when :string
      [["等于",'='],["包含",'like']]
    when :datetime
      #[["早于",'>'],["早于等于",'=>'],["等于",'='],["晚于等于",'=<'],["晚于",'<']]
      list =  [["晚于",'>'], ["晚于等于",'>='], ["等于",'=']] if position.eql? "begin"
      list =  [["早于",'<'], ["早于等于",'<='], ["等于",'=']] if position.eql? "end"
      list
    when :integer
      #[["大于",'>'],["大于等于",'=>'],["等于",'='],["小于等于",'=<'],["小于",'<']]
      list = [["大于",'>'], ["大于等于",'>='], ["等于",'=']] if position.eql? "begin"
      list = [["小于",'<'], ["小于等于",'<='], ["等于",'=']] if position.eql? "end"
      list
    else
      []
    end
  end
end
