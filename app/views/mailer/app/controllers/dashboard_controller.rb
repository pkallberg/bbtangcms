class DashboardController < ApplicationController
  authorize_resource :class => false
  def index
    @knowledges = Knowledge.find_recent(:limit => 8)
    #@comment_activity = CommentActivity.find_recent
    #@stats            = Stats.new
  end
end
