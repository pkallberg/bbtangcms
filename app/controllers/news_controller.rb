class NewsController < ApplicationController
  load_and_authorize_resource
  caches_action :index, :show, :public, :feed, :cache_path => Proc.new { |controller| current_user.present? ? controller.params.merge(user_id: current_user.id) : controller.params }
  cache_sweeper :resource_sweeper
  Model_class = News.new.class
  # GET /news
  # GET /news.json
  def index
    @news = News.paginate(:page => params[:page]).order('id DESC')

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), news_index_path
    
    
    #fresh_when :etag => [@news]
    if stale? :etag => @news
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @news }
      end
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = News.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), news_path(@news)


    if stale? :etag => [@news]
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @news }
      end
    end
  end

  # GET /news/new
  # GET /news/new.json
  def new
    @news = News.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_news_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_news_path(@news)
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(params[:news])

    @news.if_soft_deleted(params[:news][:soft_deleted],current_user) if params[:news][:soft_deleted].present?

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render json: @news, status: :created, location: @news }
      else
        format.html { render action: "new" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.json
  def update
    @news = News.find(params[:id])

    @news.if_soft_deleted(params[:news][:soft_deleted],current_user) if params[:news][:soft_deleted].present?

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_url }
      format.json { head :no_content }
    end
  end
end
