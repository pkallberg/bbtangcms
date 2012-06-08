# coding: utf-8
module BaseModel
  extend ActiveSupport::Concern
  module InstanceMethods
    # 检测敏感词
    def spam?(attr)
      value = eval("self.#{attr}")
      return false if value.blank?
      if value.class == [].class
        value = value.join(" ")
      end
      spam_reg = Regexp.new(SpamWord.spam_words)
      if matched = spam_reg.match(value.upcase)
        self.errors.add(attr,I18n.t("spam_words_errors", :errors=>matched.to_a.join(",")))
        return false
      end
    end
  end
end
