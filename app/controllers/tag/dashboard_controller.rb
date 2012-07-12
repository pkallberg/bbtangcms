class Tag::DashboardController < Tag::TagBaseController
  authorize_resource :class => false
  def show
    @root_tags = Identity.all
  end
end
