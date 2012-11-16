# encoding: utf-8
class QuizCollection
  include Mongoid::Document
  include Mongoid::Timestamps
  before_validation :set_array

  field :coll_name, type: String
  field :keywords, type: String
  field :quiz_ids, type: Array
  field :end_date, type: Date

  validates :quiz_ids, :coll_name , :keywords, :presence => true
  validates_uniqueness_of :coll_name
  #validates_presence_of :quiz_ids


  def quizzes
    if self.quiz_ids.present?
      self.quiz_ids.collect{|quiz_id| Quiz.find_by_id quiz_id}.compact.uniq
    else
      []
    end
  end

  def quiz_ids
    if self.respond_to? :ids and self.ids.present?
      self.update_attributes(quiz_ids: self.ids, ids: nil)
      return self.ids
    else
      super
    end
  end

  def to_s
    "#{self.coll_name}" if self.coll_name.present?
  end

  def set_array
    self.quiz_ids = convert_array(self.quiz_ids)
  end

  def convert_array(str=nil)
    if str.present?
     str = str.to_s.split(/，|,|;|；|\ +|\||\r\n/).collect {|t| t.to_i if t.present?}.uniq.compact
    else
      []
    end
  end
end
