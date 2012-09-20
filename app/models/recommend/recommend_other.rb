# encoding: utf-8
class Recommend::RecommendOther
  include Mongoid::Document
  #include Mongoid::Timestamps::Created
  include Mongoid::Timestamps

  before_validation :auto_update_feild

  field :recommend_other_type, type: String
  #dynamic_fields Recommend::OtherColumn.where(:recommend_type => "index_foucus").entries

  def dynamic_attributes
    #update feild
    auto_update_feild

    #attr_hash = self.attributes
    attr_hash = self.attributes.clone
    attr_hash.delete_if { |attribute|
      self.fields.keys.member? attribute
    }
  end

  def other_columns
    Recommend::OtherColumn.where(:recommend_type => self.recommend_other_type).entries.first
  end

  def dynamic_attribute_names
    dynamic_attributes.keys
  end

  def dynamic_attribute_human(col = nil)
    if col.present? and other_columns.present?
      col_index = other_columns.column_names.index(col)
      human_name = other_columns.human_names.send("[]",col_index)
      if col_index.present? and human_name.present?
        human_name
      else
        col
      end
    end
  end

  def new
    if self.recommend_other_type.present? and other_columns.present?
      columns = other_columns.column_names
      if columns.present?
        #can not work
        #columns.collect{|col| self.send("[]=",col.to_sym,nil) unless self.fields.keys.include? col.to_s}
        columns.collect{|col| self.send("[]=",col.to_sym,nil) unless self.respond_to? col.to_s}
      end
      return self
    else
      super
    end
  end

  def auto_update_feild
    if self.recommend_other_type.present? and other_columns.present?
      columns = other_columns.column_names
      if columns.present?
        columns.collect{|col| self.send("[]=",col.to_sym,nil) unless self.respond_to? col.to_s}
      end
      return self
    end
  end

  def to_s
    "#{self.recommend_other_type}" if self.recommend_other_type.present?
  end
end
