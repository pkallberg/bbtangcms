class CommonController < ApplicationController
  authorize_resource :class => false
  def search
    if (params.has_key? "model") and (params["model"].present?)
      @model_class = params[:model].constantize
      @results = @model_class.where params[:type] => params[:q]
      if @results.empty?
        @results = @model_class.where("#{params[:type].to_s} like '%#{params[:q]}%'")
      end
    end
    render :template => 'common/search_result.html.erb'
  end
end
