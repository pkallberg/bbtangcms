class Recommend::ExpertCategoriesController < Recommend::RecommendBaseController
  load_and_authorize_resource  :class =>"Recommend::ExpertCategory"
  Model_class = Recommend::ExpertCategory.new.class
  # GET /recommend/expert_categories
  # GET /recommend/expert_categories.json
  def index
    #@recommend_expert_categories = Recommend::ExpertCategory.all
    #@recommend_expert_categories = Recommend::ExpertCategory.all.asc(:sort_index).entries
    @recommend_expert_categories = Recommend::ExpertCategory.all.desc(:sort_index).entries
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_expert_categories_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_expert_categories }
    end
  end

  # GET /recommend/expert_categories/1
  # GET /recommend/expert_categories/1.json
  def show
    @recommend_expert_category = Recommend::ExpertCategory.find(params[:id])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_expert_category_path(@recommend_expert_category)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_expert_category }
    end
  end

  # GET /recommend/expert_categories/new
  # GET /recommend/expert_categories/new.json
  def new
    @recommend_expert_category = Recommend::ExpertCategory.new
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_expert_category_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_expert_category }
    end
  end

  # GET /recommend/expert_categories/1/edit
  def edit
    @recommend_expert_category = Recommend::ExpertCategory.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_expert_category_path(@recommend_expert_category)
  end

  # POST /recommend/expert_categories
  # POST /recommend/expert_categories.json
  def create
    @recommend_expert_category = Recommend::ExpertCategory.new(params[:recommend_expert_category])

    respond_to do |format|
      if @recommend_expert_category.save
        format.html { redirect_to @recommend_expert_category, notice: 'Expert category was successfully created.' }
        format.json { render json: @recommend_expert_category, status: :created, location: @recommend_expert_category }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_expert_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/expert_categories/1
  # PUT /recommend/expert_categories/1.json
  def update
    @recommend_expert_category = Recommend::ExpertCategory.find(params[:id])

    respond_to do |format|
      if @recommend_expert_category.update_attributes(params[:recommend_expert_category])
        format.html { redirect_to @recommend_expert_category, notice: 'Expert category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_expert_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/expert_categories/1
  # DELETE /recommend/expert_categories/1.json
  def destroy
    @recommend_expert_category = Recommend::ExpertCategory.find(params[:id])
    @recommend_expert_category.destroy

    respond_to do |format|
      format.html { redirect_to recommend_expert_categories_url }
      format.json { head :no_content }
    end
  end
end
