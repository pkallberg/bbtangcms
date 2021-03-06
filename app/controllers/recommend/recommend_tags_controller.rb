class Recommend::RecommendTagsController < Recommend::RecommendBaseController
  load_and_authorize_resource  :class =>"Recommend::RecommendTag"
  Model_class = Recommend::RecommendTag.new.class
  # GET /recommend/recommend_tags
  # GET /recommend/recommend_tags.json
  def index
    @recommend_recommend_tags = Recommend::RecommendTag.paginate(:page => params[:page])
    #@recommend_recommend_tags = Recommend::RecommendTag.paginate(:page => params[:page], :per_page => 20).order('id DESC')

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_tags_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_tags }
    end
  end

  # GET /recommend/recommend_tags/1
  # GET /recommend/recommend_tags/1.json
  def show
    @recommend_recommend_tag = Recommend::RecommendTag.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_tag_path(@recommend_recommend_tag)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_tag }
    end
  end

  # GET /recommend/recommend_tags/new
  # GET /recommend/recommend_tags/new.json
  def new
    @recommend_recommend_tag = Recommend::RecommendTag.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_tag_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_tag }
    end
  end

  # GET /recommend/recommend_tags/1/edit
  def edit
    @recommend_recommend_tag = Recommend::RecommendTag.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_tag_path(@recommend_recommend_tag)
  end

  # POST /recommend/recommend_tags
  # POST /recommend/recommend_tags.json
  def create
    @recommend_recommend_tag = Recommend::RecommendTag.new(params[:recommend_recommend_tag])

    respond_to do |format|
      if @recommend_recommend_tag.save
        format.html { redirect_to @recommend_recommend_tag, notice: 'Recommend tag was successfully created.' }
        format.json { render json: @recommend_recommend_tag, status: :created, location: @recommend_recommend_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/recommend_tags/1
  # PUT /recommend/recommend_tags/1.json
  def update
    @recommend_recommend_tag = Recommend::RecommendTag.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_tag.update_attributes(params[:recommend_recommend_tag])
        format.html { redirect_to @recommend_recommend_tag, notice: 'Recommend tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_tags/1
  # DELETE /recommend/recommend_tags/1.json
  def destroy
    @recommend_recommend_tag = Recommend::RecommendTag.find(params[:id])
    @recommend_recommend_tag.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_tags_url }
      format.json { head :no_content }
    end
  end
end
