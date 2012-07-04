class Recommend::RecommendHindicesController < Recommend::RecommendBaseController
  load_and_authorize_resource
  Model_class = Recommend::RecommendHindex.new.class
  # GET /recommend/recommend_hindices
  # GET /recommend/recommend_hindices.json
  def index
    @recommend_recommend_hindices = Recommend::RecommendHindex.all.entries

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_hindices_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_hindices }
    end
  end

  # GET /recommend/recommend_hindices/1
  # GET /recommend/recommend_hindices/1.json
  def show
    @recommend_recommend_hindex = Recommend::RecommendHindex.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_hindex_path(@recommend_recommend_event)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_hindex }
    end
  end

  # GET /recommend/recommend_hindices/new
  # GET /recommend/recommend_hindices/new.json
  def new
    @recommend_recommend_hindex = Recommend::RecommendHindex.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_hindex_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_hindex }
    end
  end

  # GET /recommend/recommend_hindices/1/edit
  def edit
    @recommend_recommend_hindex = Recommend::RecommendHindex.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_hindex_path(@recommend_recommend_event)
  end

  # POST /recommend/recommend_hindices
  # POST /recommend/recommend_hindices.json
  def create
    @recommend_recommend_hindex = Recommend::RecommendHindex.new(params[:recommend_recommend_hindex])

    respond_to do |format|
      if @recommend_recommend_hindex.save
        format.html { redirect_to @recommend_recommend_hindex, notice: 'Recommend hindex was successfully created.' }
        format.json { render json: @recommend_recommend_hindex, status: :created, location: @recommend_recommend_hindex }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_hindex.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/recommend_hindices/1
  # PUT /recommend/recommend_hindices/1.json
  def update
    @recommend_recommend_hindex = Recommend::RecommendHindex.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_hindex.update_attributes(params[:recommend_recommend_hindex])
        format.html { redirect_to @recommend_recommend_hindex, notice: 'Recommend hindex was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_hindex.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_hindices/1
  # DELETE /recommend/recommend_hindices/1.json
  def destroy
    @recommend_recommend_hindex = Recommend::RecommendHindex.find(params[:id])
    @recommend_recommend_hindex.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_hindices_url }
      format.json { head :no_content }
    end
  end
end
