# coding: utf-8
class ProfilesController < ApplicationController
  load_and_authorize_resource
  caches_action :index, :show, :public, :feed
  cache_sweeper :resource_sweeper
  Model_class = Profile.new.class

  # GET /profiles
  # GET /profiles.json
  def index
    if params[:conditions].present?
      @profiles = Profile.where(params[:conditions]).paginate(:page => params[:page]).order('id DESC')
    else
      @profiles = Profile.paginate(:page => params[:page]).order('id DESC')
    end

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), profiles_path
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), profile_path(@profile)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    ip = request.env["REMOTE_ADDR"] if not request.env["REMOTE_ADDR"]=='127.0.0.1'
    @contry = change_ip_to_city(ip)
    @profile = Profile.new
    set_instace_var

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    ip = request.env["REMOTE_ADDR"] if not request.env["REMOTE_ADDR"] == '127.0.0.1'
    @contry = change_ip_to_city(ip)
    @profile = Profile.find(params[:id])
    set_instace_var

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_profile_path(@profile)
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end

  protected
  def set_instace_var
    if self.instance_variable_defined? "@profile"
      (3 - @profile.babies.length).times { @profile.babies.new }
    end
  end
  def change_ip_to_city (ip=nil)
    is = IpSearch.new
    ip ||= "116.228.214.170"
    is.find_ip_location(ip)
    #breakpoint
    return is.country[0].gsub("市","")
  end
end
