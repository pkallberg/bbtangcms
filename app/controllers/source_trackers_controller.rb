class SourceTrackersController < ApplicationController
  skip_before_filter :authenticate_user!
  Model_class = SourceTracker.new.class
    
  # GET /source_trackers
  # GET /source_trackers.json
  def index
    @source_trackers = SourceTracker.desc(:_id).paginate(:page => params[:page])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), source_trackers_path
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @source_trackers }
    end
  end

  # GET /source_trackers/1
  # GET /source_trackers/1.json
  def show
    @source_tracker = SourceTracker.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @source_tracker }
    end
  end

  # GET /source_trackers/new
  # GET /source_trackers/new.json
  def new
    if params.has_key? "source_tracker"
      source_tracker = params[:source_tracker].merge({url: request.url, ip: request.remote_ip})

      @source_tracker = SourceTracker.new(source_tracker)
      @source_tracker.save
    end
    respond_to do |format|
      #format.html # index.html.erb
      format.json { render json: @source_trackers }
    end
  end

  # GET /source_trackers/1/edit
  def edit
    @source_tracker = SourceTracker.find(params[:id])
  end

  # POST /source_trackers
  # POST /source_trackers.json
  def create
    @source_tracker = SourceTracker.new(params[:source_tracker])

    respond_to do |format|
      if @source_tracker.save
        format.html { redirect_to @source_tracker, notice: 'Source tracker was successfully created.' }
        format.json { render json: @source_tracker, status: :created, location: @source_tracker }
      else
        format.html { render action: "new" }
        format.json { render json: @source_tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /source_trackers/1
  # PUT /source_trackers/1.json
  def update
    @source_tracker = SourceTracker.find(params[:id])

    respond_to do |format|
      if @source_tracker.update_attributes(params[:source_tracker])
        format.html { redirect_to @source_tracker, notice: 'Source tracker was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @source_tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /source_trackers/1
  # DELETE /source_trackers/1.json
  def destroy
    @source_tracker = SourceTracker.find(params[:id])
    @source_tracker.destroy

    respond_to do |format|
      format.html { redirect_to source_trackers_url }
      format.json { head :no_content }
    end
  end
end
