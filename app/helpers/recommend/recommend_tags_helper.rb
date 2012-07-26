module Recommend::RecommendTagsHelper
  def get_hot_tags(model = '',count = '20',tags_list = [:tags, :categories])
    if model.present? and count.present?
      @model_class = model.constantize
      #@tags = @model_class.identity_counts
      #tags_list = [:tags, :timelines, :categories, :identities]
      tags_list.each do |tag|
        if @model_class.respond_to?("#{tag.to_s.singularize}_counts")
          #@tags = @model_class.tag_counts_on(:tags)
          unless  self.instance_variable_defined? "@#{tag}"
            #eg @tags = @model_class.tags_counts
            tag_list = @model_class.send("#{tag.to_s.singularize}_counts")
            self.instance_variable_set "@#{model.downcase}_#{tag}",tag_list.order('count DESC')[0 .. "#{count}".to_i]
          end
        end
      end
    end
  end
end
