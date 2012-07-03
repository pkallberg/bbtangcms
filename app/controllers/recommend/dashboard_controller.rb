class Recommend::DashboardController < Recommend::RecommendBaseController
  authorize_resource :class => false
  def show
  end
end
