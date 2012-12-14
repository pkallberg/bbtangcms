class SourceTrackersController < ApplicationController
  skip_before_filter :authenticate_user!
  caches_action :index, :show, :public, :feed, :cache_path => Proc.new { |controller| controller.params }
  cache_sweeper :resource_sweeper
  Model_class = SourceTracker.new.class
    
  # GET /source_trackers
  # GET /source_trackers.json
  def index
    if params[:conditions].present?
      conditions = params[:conditions]
      conditions = Hash[conditions.collect{|k,v| (v.class.eql? Array) ? [k.to_sym.in,v] : [k,v]}]
      @source_trackers  = SourceTracker.where(conditions).desc(:_id).paginate(:page => params[:page])
    else
      @source_trackers  = SourceTracker.desc(:_id).paginate(:page => params[:page])
    end
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
  
  #get or post
  def query
    has_key = SourceTracker.name.underscore

    if params.has_key? has_key and params[has_key].present?
      redirect_to source_trackers_path(conditions: params[has_key])
    end
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
