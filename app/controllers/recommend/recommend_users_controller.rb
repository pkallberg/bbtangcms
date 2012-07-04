class Recommend::RecommendUsersController < Recommend::RecommendBaseController
  load_and_authorize_resource
  Model_class = Recommend::RecommendUser.new.class
  # GET /recommend/recommend_users
  # GET /recommend/recommend_users.json
  def index
    @recommend_recommend_users = Recommend::RecommendUser.all.entries

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_users_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_users }
    end
  end

  # GET /recommend/recommend_users/1
  # GET /recommend/recommend_users/1.json
  def show
    @recommend_recommend_user = Recommend::RecommendUser.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_user_path

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_user }
    end
  end

  # GET /recommend/recommend_users/new
  # GET /recommend/recommend_users/new.json
  def new
    @recommend_recommend_user = Recommend::RecommendUser.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_user_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_user }
    end
  end

  # GET /recommend/recommend_users/1/edit
  def edit
    @recommend_recommend_user = Recommend::RecommendUser.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_user_path(@recommend_recommend_user)
  end

  # POST /recommend/recommend_users
  # POST /recommend/recommend_users.json
  def create
    @recommend_recommend_user = Recommend::RecommendUser.new(params[:recommend_recommend_user])

    respond_to do |format|
      if @recommend_recommend_user.save
        format.html { redirect_to @recommend_recommend_user, notice: 'Recommend user was successfully created.' }
        format.json { render json: @recommend_recommend_user, status: :created, location: @recommend_recommend_user }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/recommend_users/1
  # PUT /recommend/recommend_users/1.json
  def update
    @recommend_recommend_user = Recommend::RecommendUser.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_user.update_attributes(params[:recommend_recommend_user])
        format.html { redirect_to @recommend_recommend_user, notice: 'Recommend user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_users/1
  # DELETE /recommend/recommend_users/1.json
  def destroy
    @recommend_recommend_user = Recommend::RecommendUser.find(params[:id])
    @recommend_recommend_user.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_users_url }
      format.json { head :no_content }
    end
  end
end
