class Auth::DashboardController < Auth::AuthBaseController
  authorize_resource :class => false
  def show
  end
end
