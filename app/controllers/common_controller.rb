class CommonController < ApplicationController
  authorize_resource :class => false
  def search

    if (params.has_key? "model") and (params["model"].present?)
      @model_class = params[:model].constantize
      #query_word = params[:q]
      #@results = @model_class.where params[:type] => query_word
      # if params[:type].singularize.gsub("_id","").classify.class_exists?
      #if @results.empty?
      #  @results = @model_class.where("#{params[:type].to_s} like '%#{query_word}%'")
      #end
      find_item(q_model = @model_class,q_type = params[:type].to_s, q_word = params[:q].to_s)

      breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => @model_class.model_name.human), :search
    end

    render :template => 'common/search_result.html.erb'
  end

  private
  def find_item(q_model = nil,q_type = nil, q_word = nil)
    @results = []
    human_col = ['title','name','email','username','nickname']
    if q_model.present? and q_type.present? and q_word.present?
      @results = q_model.where q_type => q_word
      if @results.empty?
        if q_type.singularize.gsub("_id","").classify.class_exists?
          ass_result = []
          ass_model =  q_type.singularize.gsub("_id","").classify.constantize

          human_col.each do |col|
            if ass_model.column_names.include? col
              ass_result.append (ass_model.where col => q_word).first if (ass_model.where col => q_word).present?
            end
          end
        if ass_result.present?
          q_word = ass_result.first.id
          @results = q_model.where q_type => q_word
        end
        else
          @results = @model_class.where("#{q_type} like '%#{q_word}%'")
        end
      end
    end
  end

end
