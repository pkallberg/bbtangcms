=begin
 added by ivan
 create ActiveRecord Extensions 
=end

module BBTangCMS::ActiveRecordExtensions
  # add your instance methods here, eg:
  # def test
  #   "test"
  # end
  
  module ClassMethods
    # add your static(class) methods here
    # def test param
    #   class_attribute :self_test
    #   self.self_test = "test" << param
    # end
    def self_model_name
      class_attribute :self_model_name
      self.self_model_name = self.name #初始话该model的名字
    end
    def self_model_id
      class_attribute :self_model_id
      self.self_model_id = BBTangCMS::MetaCache.get_data_by_name("model_objects", self.name) #从缓存读取该model所对应id
    end
    
  end
   
  def self.included(receiver)
    receiver.extend BBTangCMS::ActiveRecordExtensions::ClassMethods
  end   
end
 
