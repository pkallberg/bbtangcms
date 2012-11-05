class QuizCenter::DashboardController < QuizCenter::QuizCenterBaseController
  authorize_resource :class => false
  def show
  end
end
