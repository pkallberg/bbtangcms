class HotTagsController < ApplicationController
  def index
    if (params.has_key? "model") and (params["model"].present?)
      @model_class = params[:model].constantize
      #@tags = @model_class.identity_counts
      tags_list = [:tags, :timelines, :categories, :identities]
      tags_list.each do |tag|
        if @model_class.respond_to?("#{tag.to_s.singularize}_counts")
          #@tags = @model_class.tag_counts_on(:tags)
          unless  self.instance_variable_defined? "@#{tag}"
            #eg @tags = @model_class.tags_counts
            self.instance_variable_set "@#{tag}",@model_class.send("#{tag.to_s.singularize}_counts")
          end
        end
      end
    end
  end

end
