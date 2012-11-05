class PageRequestsController < ApplicationController
  def index
    #@page_requests = PageRequest.all.entries[0..100]
    @page_requests = PageRequest.all.sort({_id:-1}).limit(400);
  end
end
