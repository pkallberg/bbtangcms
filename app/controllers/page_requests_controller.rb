class PageRequestsController < ApplicationController
  Model_class = PageRequest.new.class
  
  def index
    #@page_requests = PageRequest.all.entries[0..100]
    if params[:conditions].present?
      conditions = params[:conditions]
      conditions = Hash[conditions.collect{|k,v| (v.class.eql? Array) ? [k.to_sym.in,v] : [k,v]}]
      @page_requests  = PageRequest.where(conditions).desc(:_id).paginate(:page => params[:page],per_page: 50)
    else
      @page_requests  = PageRequest.desc(:_id).paginate(:page => params[:page],per_page: 50)
    end
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), page_requests_path
  end
end
