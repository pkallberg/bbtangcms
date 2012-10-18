class Recommend::RecommendAppsController < Recommend::RecommendBaseController
  load_and_authorize_resource :class =>"Recommend::RecommendApp"
  Model_class = Recommend::RecommendApp.new.class
  # GET /recommend/recommend_apps
  # GET /recommend/recommend_apps.json
  def index
    @recommend_recommend_apps = Recommend::RecommendApp.all.entries

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_apps_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_apps }
    end
  end

  # GET /recommend/recommend_apps/1
  # GET /recommend/recommend_apps/1.json
  def show
    @recommend_recommend_app = Recommend::RecommendApp.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_app_path(@recommend_recommend_app)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_app }
    end
  end

  # GET /recommend/recommend_apps/new
  # GET /recommend/recommend_apps/new.json
  def new
    @recommend_recommend_app = Recommend::RecommendApp.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_app_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_app }
    end
  end

  # GET /recommend/recommend_apps/1/edit
  def edit
    @recommend_recommend_app = Recommend::RecommendApp.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_app_path(@recommend_recommend_app)
  end

  # POST /recommend/recommend_apps
  # POST /recommend/recommend_apps.json
  def create
    @recommend_recommend_app = Recommend::RecommendApp.new(params[:recommend_recommend_app])

    respond_to do |format|
      if @recommend_recommend_app.save
        format.html { redirect_to @recommend_recommend_app, notice: 'Recommend app was successfully created.' }
        format.json { render json: @recommend_recommend_app, status: :created, location: @recommend_recommend_app }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/recommend_apps/1
  # PUT /recommend/recommend_apps/1.json
  def update
    @recommend_recommend_app = Recommend::RecommendApp.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_app.update_attributes(params[:recommend_recommend_app])
        format.html { redirect_to @recommend_recommend_app, notice: 'Recommend app was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_apps/1
  # DELETE /recommend/recommend_apps/1.json
  def destroy
    @recommend_recommend_app = Recommend::RecommendApp.find(params[:id])
    @recommend_recommend_app.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_apps_url }
      format.json { head :no_content }
    end
  end
end
