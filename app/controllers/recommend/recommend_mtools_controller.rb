class Recommend::RecommendMtoolsController < Recommend::RecommendBaseController
  load_and_authorize_resource  :class =>"Recommend::RecommendMtool"
  Model_class = Recommend::RecommendMtool.new.class
  # GET /recommend/recommend_mtools
  # GET /recommend/recommend_mtools.json
  def index
    @recommend_recommend_mtools = Recommend::RecommendMtool.paginate(:page => params[:page])
    
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_mtools_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_mtools }
    end
  end

  # GET /recommend/recommend_mtools/1
  # GET /recommend/recommend_mtools/1.json
  def show
    @recommend_recommend_mtool = Recommend::RecommendMtool.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_mtool_path(@recommend_recommend_mtool)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_mtool }
    end
  end

  # GET /recommend/recommend_mtools/new
  # GET /recommend/recommend_mtools/new.json
  def new
    @recommend_recommend_mtool = Recommend::RecommendMtool.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_mtool_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_mtool }
    end
  end

  # GET /recommend/recommend_mtools/1/edit
  def edit
    @recommend_recommend_mtool = Recommend::RecommendMtool.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_mtool_path(@recommend_recommend_mtool)
  end

  # POST /recommend/recommend_mtools
  # POST /recommend/recommend_mtools.json
  def create
    @recommend_recommend_mtool = Recommend::RecommendMtool.new(params[:recommend_recommend_mtool])

    respond_to do |format|
      if @recommend_recommend_mtool.save
        format.html { redirect_to @recommend_recommend_mtool, notice: 'Recommend mtool was successfully created.' }
        format.json { render json: @recommend_recommend_mtool, status: :created, location: @recommend_recommend_mtool }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_mtool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/recommend_mtools/1
  # PUT /recommend/recommend_mtools/1.json
  def update
    @recommend_recommend_mtool = Recommend::RecommendMtool.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_mtool.update_attributes(params[:recommend_recommend_mtool])
        format.html { redirect_to @recommend_recommend_mtool, notice: 'Recommend mtool was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_mtool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_mtools/1
  # DELETE /recommend/recommend_mtools/1.json
  def destroy
    @recommend_recommend_mtool = Recommend::RecommendMtool.find(params[:id])
    @recommend_recommend_mtool.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_mtools_url }
      format.json { head :no_content }
    end
  end
end
