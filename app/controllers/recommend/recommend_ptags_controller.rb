class Recommend::RecommendPtagsController < Recommend::RecommendBaseController
  load_and_authorize_resource  :class =>"Recommend::RecommendPtag"
  Model_class = Recommend::RecommendPtag.new.class
  # GET /recommend/recommend_ptags
  # GET /recommend/recommend_ptags.json
  def index
    @recommend_recommend_ptags = Recommend::RecommendPtag.paginate(:page => params[:page])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_ptags_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_ptags }
    end
  end

  # GET /recommend/recommend_ptags/1
  # GET /recommend/recommend_ptags/1.json
  def show
    @recommend_recommend_ptag = Recommend::RecommendPtag.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_ptag_path(@recommend_recommend_ptag)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_ptag }
    end
  end

  # GET /recommend/recommend_ptags/new
  # GET /recommend/recommend_ptags/new.json
  def new
    @recommend_recommend_ptag = Recommend::RecommendPtag.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_ptag_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_ptag }
    end
  end

  # GET /recommend/recommend_ptags/1/edit
  def edit
    @recommend_recommend_ptag = Recommend::RecommendPtag.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_ptag_path(@recommend_recommend_ptag)
  end

  # POST /recommend/recommend_ptags
  # POST /recommend/recommend_ptags.json
  def create
    @recommend_recommend_ptag = Recommend::RecommendPtag.new(params[:recommend_recommend_ptag])

    respond_to do |format|
      if @recommend_recommend_ptag.save
        format.html { redirect_to @recommend_recommend_ptag, notice: 'Recommend ptag was successfully created.' }
        format.json { render json: @recommend_recommend_ptag, status: :created, location: @recommend_recommend_ptag }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_ptag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/recommend_ptags/1
  # PUT /recommend/recommend_ptags/1.json
  def update
    @recommend_recommend_ptag = Recommend::RecommendPtag.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_ptag.update_attributes(params[:recommend_recommend_ptag])
        format.html { redirect_to @recommend_recommend_ptag, notice: 'Recommend ptag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_ptag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_ptags/1
  # DELETE /recommend/recommend_ptags/1.json
  def destroy
    @recommend_recommend_ptag = Recommend::RecommendPtag.find(params[:id])
    @recommend_recommend_ptag.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_ptags_url }
      format.json { head :no_content }
    end
  end
end
