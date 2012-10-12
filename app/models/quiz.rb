class Quiz < ActiveRecord::Base
  belongs_to :knowledge

  def answer_correct?
    true
  end

  def right_percent
    (self.cnt_true.to_f/(self.cnt_true.to_f+self.cnt_false.to_f)*100).round rescue 100
  end

  def wrong_percent
    100 - right_percent
  end
end
