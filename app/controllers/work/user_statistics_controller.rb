class Work::UserStatisticsController < Work::WorkBaseController
  # GET /work/user_statistics
  # GET /work/user_statistics.json
  def index
    @units = %w(day month year week)
    @unit = params[:group_by] if params[:group_by] and @units.include? params[:group_by]
    @unit ||= "day"
    @mod = "User"
  end

  def filter
    @units = %w(day month year week)
    @unit = params[:group_by] if params[:group_by] and @units.include? params[:group_by]
    @unit ||= "day"
    @mod = "User"
    if params[:s_time].present? and params[:s_time].to_date
    @s_time = params[:s_time].to_date
    end
    if params[:e_time].present? and params[:s_time].to_date
    @e_time = params[:e_time].to_date
    end
    @e_time ||= Date.today
    @s_time ||= 1.day.ago
  end

  # GET /work/user_statistics/1
  # GET /work/user_statistics/1.json
  def show
    @work_user_statistic = Work::UserStatistic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @work_user_statistic }
    end
  end

  # GET /work/user_statistics/new
  # GET /work/user_statistics/new.json
  def new
    @work_user_statistic = Work::UserStatistic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @work_user_statistic }
    end
  end

  # GET /work/user_statistics/1/edit
  def edit
    @work_user_statistic = Work::UserStatistic.find(params[:id])
  end

  # POST /work/user_statistics
  # POST /work/user_statistics.json
  def create
    @work_user_statistic = Work::UserStatistic.new(params[:work_user_statistic])

    respond_to do |format|
      if @work_user_statistic.save
        format.html { redirect_to @work_user_statistic, notice: 'User statistic was successfully created.' }
        format.json { render json: @work_user_statistic, status: :created, location: @work_user_statistic }
      else
        format.html { render action: "new" }
        format.json { render json: @work_user_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /work/user_statistics/1
  # PUT /work/user_statistics/1.json
  def update
    @work_user_statistic = Work::UserStatistic.find(params[:id])

    respond_to do |format|
      if @work_user_statistic.update_attributes(params[:work_user_statistic])
        format.html { redirect_to @work_user_statistic, notice: 'User statistic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @work_user_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work/user_statistics/1
  # DELETE /work/user_statistics/1.json
  def destroy
    @work_user_statistic = Work::UserStatistic.find(params[:id])
    @work_user_statistic.destroy

    respond_to do |format|
      format.html { redirect_to work_user_statistics_url }
      format.json { head :no_content }
    end
  end
end
