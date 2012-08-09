class Work::DashboardController < Work::WorkBaseController
  authorize_resource :class => false
  # GET /work/dashboards/1
  # GET /work/dashboards/1.json
  def show
    if current_user.present?
      #@work_dashboard = Work::Dashboard.find(params[:id])
      @worked_list = Setting.version_mod.split(' ')
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @work_dashboard }
      end
    end
  end


end
