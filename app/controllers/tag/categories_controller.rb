class Tag::CategoriesController < Tag::TagBaseController
  load_and_authorize_resource
  #load_and_authorize_resource :identity
  #load_and_authorize_resource :timeline
  #load_resource :identity
  #load_resource :timeline
  #load_and_authorize_resource :category, :through => [:timeline], :shallow => true
  Model_class = Category.new.class
  before_filter :load_parent

  # GET /tag/categories
  # GET /tag/categories.json
  def index
    #@tag_categories = Category.all
    @tag_categories = @timeline.children.paginate(:page => params[:page]).order('id DESC')

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), tag_identity_timeline_categories_path(@identity,@timeline)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tag_categories }
    end
  end

  # GET /tag/categories/1
  # GET /tag/categories/1.json
  def show
    @tag_category = Category.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), tag_identity_timeline_category_path(@identity,@timeline,@tag_category)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag_category }
    end
  end

  # GET /tag/categories/new
  # GET /tag/categories/new.json
  def new
    #@tag_category = @timeline.children.new
    @tag_category = Category.new()

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_tag_identity_timeline_category_path(@identity,@timeline)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag_category }
    end
  end

  # GET /tag/categories/1/edit
  def edit
    @tag_category = Category.find(params[:id])
  end

  # POST /tag/categories
  # POST /tag/categories.json
  def create
    @tag_category = Category.new(params[:category])
    @tag_category.parent_id = @timeline.id if @timeline.present?

    respond_to do |format|
      if @tag_category.save
        format.html { redirect_to tag_identity_timeline_category_path(@identity,@timeline,@tag_category), notice: 'Category was successfully created.' }
        format.json { render json: @tag_category, status: :created, location: @tag_category }
      else
        format.html { render action: "new" }
        format.json { render json: @tag_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tag/categories/1
  # PUT /tag/categories/1.json
  def update
    @tag_category = Category.find(params[:id])
    @tag_category.parent_id = @timeline.id if @timeline.present?

    respond_to do |format|
      if @tag_category.update_attributes(params[:category])
        format.html { redirect_to tag_identity_timeline_category_path(@identity,@timeline,@tag_category), notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag/categories/1
  # DELETE /tag/categories/1.json
  def destroy
    @tag_category = Category.find(params[:id])
    @tag_category.destroy

    respond_to do |format|
      format.html { redirect_to tag_identity_timeline_categories_url(@identity,@timeline) }
      format.json { head :no_content }
    end
  end

    def load_parent

      @identity = Identity.find(params[:identity_id])
      @timeline = Timeline.find(params[:timeline_id])
    end
end
