class Work::VersionsController < Work::WorkBaseController
  authorize_resource

  Model_class = Version.new.class
  # GET /work/versions
  # GET /work/versions.json
  def index
    @work_versions =  Version.paginate(:page => params[:page]).order('id DESC')

    if params[:version].present? and params[:version].has_key? "created_at"
      @work_versions = Version.where(created_at: params[:version]["created_at"].to_time .. params[:version]["created_at"].to_time + 1.day).paginate(:page => params[:page])
    else
      @work_versions = Version.paginate(:page => params[:page],
                       :conditions => params[:version]
                    )  if params[:version].present?
    end

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), work_versions_path
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @work_versions }
    end
  end

  # GET /work/versions/1
  # GET /work/versions/1.json
  def show
    @work_version = Version.find(params[:id])


    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), work_version_path(@work_version)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @work_version }
    end
  end

  # GET /work/versions/new
  # GET /work/versions/new.json
  def new
    @work_version = Work::Version.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @work_version }
    end
  end

  # GET /work/versions/1/edit
  def edit
    @work_version = Work::Version.find(params[:id])
  end

  # POST /work/versions
  # POST /work/versions.json
  def create
    @work_version = Work::Version.new(params[:work_version])

    respond_to do |format|
      if @work_version.save
        format.html { redirect_to @work_version, notice: 'Version was successfully created.' }
        format.json { render json: @work_version, status: :created, location: @work_version }
      else
        format.html { render action: "new" }
        format.json { render json: @work_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /work/versions/1
  # PUT /work/versions/1.json
  def update
    @work_version = Work::Version.find(params[:id])

    respond_to do |format|
      if @work_version.update_attributes(params[:work_version])
        format.html { redirect_to @work_version, notice: 'Version was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @work_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work/versions/1
  # DELETE /work/versions/1.json
  def destroy
    @work_version = Work::Version.find(params[:id])
    @work_version.destroy

    respond_to do |format|
      format.html { redirect_to work_versions_url }
      format.json { head :no_content }
    end
  end
end
