class PageRequestsController < ApplicationController
  def index
    #@page_requests = PageRequest.all.entries[0..100]
    @page_requests = PageRequest.desc(:_id).paginate(:page => params[:page],per_page: 50)
  end
end
