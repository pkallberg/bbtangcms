class Recommend::RecommendOthersController < Recommend::RecommendBaseController
  load_and_authorize_resource  :class =>"Recommend::RecommendOther", :except => :update_field
  Model_class = Recommend::RecommendOther.new.class
  # GET /recommend/recommend_others
  # GET /recommend/recommend_others.json
  def index
    @recommend_recommend_others = Recommend::RecommendOther.all.desc(:recommend_other_type).desc(:_id).entries

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_others_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_others }
    end
  end

  # GET /recommend/recommend_others/1
  # GET /recommend/recommend_others/1.json
  def show
    @recommend_recommend_other = Recommend::RecommendOther.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_other_path(@recommend_recommend_other)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_other }
    end
  end

  # GET /recommend/recommend_others/new
  # GET /recommend/recommend_others/new.json
  def new
    @recommend_recommend_other = Recommend::RecommendOther.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_other_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_other }
    end
  end

  # GET /recommend/recommend_others/1/edit
  def edit
    @recommend_recommend_other = Recommend::RecommendOther.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_other_path(@recommend_recommend_other)
  end

  # POST /recommend/recommend_others
  # POST /recommend/recommend_others.json
  def create
    @recommend_recommend_other = Recommend::RecommendOther.new(params[:recommend_recommend_other])

    respond_to do |format|
      if @recommend_recommend_other.save
        format.html { redirect_to @recommend_recommend_other, notice: 'Recommend other was successfully created.' }
        format.json { render json: @recommend_recommend_other, status: :created, location: @recommend_recommend_other }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_other.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_field
    recommend_other_type = params[:recommend_other_type]

    if recommend_other_type.present? and params[:recommend_other_id].present? and Recommend::RecommendOther.find(params[:recommend_other_id])
      @recommend_recommend_other = Recommend::RecommendOther.find(params[:recommend_other_id])
    end
    @recommend_recommend_other ||= Recommend::RecommendOther.new
    @recommend_recommend_other.recommend_other_type = recommend_other_type
    @recommend_recommend_other.auto_update_feild
  end

  # PUT /recommend/recommend_others/1
  # PUT /recommend/recommend_others/1.json
  def update
    @recommend_recommend_other = Recommend::RecommendOther.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_other.update_attributes(params[:recommend_recommend_other])
        format.html { redirect_to @recommend_recommend_other, notice: 'Recommend other was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_other.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_others/1
  # DELETE /recommend/recommend_others/1.json
  def destroy
    @recommend_recommend_other = Recommend::RecommendOther.find(params[:id])
    @recommend_recommend_other.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_others_url }
      format.json { head :no_content }
    end
  end
end
