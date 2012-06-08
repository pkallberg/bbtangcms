class DashboardController < ApplicationController


  def index
    @knowledges = Knowledge.find_recent(:limit => 8)
    #@comment_activity = CommentActivity.find_recent
    #@stats            = Stats.new
  end
end
