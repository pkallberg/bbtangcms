class CommonController < ApplicationController
  authorize_resource :class => false
  def search
    if (params.has_key? "model") and (params["model"].present?)
      @model_class = params[:model].constantize
      @results = @model_class.where params[:type] => params[:q]
    end
    render :template => 'common/search_result.html.erb'
  end
end
