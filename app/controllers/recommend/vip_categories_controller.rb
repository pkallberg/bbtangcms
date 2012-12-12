class Recommend::VipCategoriesController < Recommend::RecommendBaseController
  load_and_authorize_resource  :class =>"Recommend::VipCategory"
  Model_class = Recommend::VipCategory.new.class
  # GET /recommend/vip_categories
  # GET /recommend/vip_categories.json
  def index
    @recommend_vip_categories = Recommend::VipCategory.paginate(:page => params[:page])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_vip_categories_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_vip_categories }
    end
  end

  # GET /recommend/vip_categories/1
  # GET /recommend/vip_categories/1.json
  def show
    @recommend_vip_category = Recommend::VipCategory.find(params[:id])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_vip_category_path(@recommend_vip_category)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_vip_category }
    end
  end

  # GET /recommend/vip_categories/new
  # GET /recommend/vip_categories/new.json
  def new
    @recommend_vip_category = Recommend::VipCategory.new
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_vip_category_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_vip_category }
    end
  end

  # GET /recommend/vip_categories/1/edit
  def edit
    @recommend_vip_category = Recommend::VipCategory.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_vip_category_path(@recommend_vip_category)
  end

  # POST /recommend/vip_categories
  # POST /recommend/vip_categories.json
  def create
    @recommend_vip_category = Recommend::VipCategory.new(params[:recommend_vip_category])

    respond_to do |format|
      if @recommend_vip_category.save
        format.html { redirect_to @recommend_vip_category, notice: 'Vip category was successfully created.' }
        format.json { render json: @recommend_vip_category, status: :created, location: @recommend_vip_category }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_vip_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/vip_categories/1
  # PUT /recommend/vip_categories/1.json
  def update
    @recommend_vip_category = Recommend::VipCategory.find(params[:id])

    respond_to do |format|
      if @recommend_vip_category.update_attributes(params[:recommend_vip_category])
        format.html { redirect_to @recommend_vip_category, notice: 'Vip category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_vip_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/vip_categories/1
  # DELETE /recommend/vip_categories/1.json
  def destroy
    @recommend_vip_category = Recommend::VipCategory.find(params[:id])
    @recommend_vip_category.destroy

    respond_to do |format|
      format.html { redirect_to recommend_vip_categories_url }
      format.json { head :no_content }
    end
  end
end
