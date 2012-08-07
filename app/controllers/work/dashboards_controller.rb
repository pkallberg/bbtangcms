class Work::DashboardsController < Work::WorkBaseController
  # GET /work/dashboards
  # GET /work/dashboards.json
  def index
    @work_dashboards = Work::Dashboard.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @work_dashboards }
    end
  end

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

  # GET /work/dashboards/new
  # GET /work/dashboards/new.json
  def new
    @work_dashboard = Work::Dashboard.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @work_dashboard }
    end
  end

  # GET /work/dashboards/1/edit
  def edit
    @work_dashboard = Work::Dashboard.find(params[:id])
  end

  # POST /work/dashboards
  # POST /work/dashboards.json
  def create
    @work_dashboard = Work::Dashboard.new(params[:work_dashboard])

    respond_to do |format|
      if @work_dashboard.save
        format.html { redirect_to @work_dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render json: @work_dashboard, status: :created, location: @work_dashboard }
      else
        format.html { render action: "new" }
        format.json { render json: @work_dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /work/dashboards/1
  # PUT /work/dashboards/1.json
  def update
    @work_dashboard = Work::Dashboard.find(params[:id])

    respond_to do |format|
      if @work_dashboard.update_attributes(params[:work_dashboard])
        format.html { redirect_to @work_dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @work_dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work/dashboards/1
  # DELETE /work/dashboards/1.json
  def destroy
    @work_dashboard = Work::Dashboard.find(params[:id])
    @work_dashboard.destroy

    respond_to do |format|
      format.html { redirect_to work_dashboards_url }
      format.json { head :no_content }
    end
  end
end
