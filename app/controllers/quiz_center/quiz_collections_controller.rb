class QuizCenter::QuizCollectionsController < QuizCenter::QuizCenterBaseController
  load_and_authorize_resource
  caches_action :index, :feed, expires_in: 10.minutes, cache_path: Proc.new { |controller| current_user.present? ? controller.params.merge(user_id: current_user.id) : controller.params }
  caches_action :show, :public, expires_in: 1.hours, cache_path: Proc.new { |controller| current_user.present? ? controller.params.merge(user_id: current_user.id) : controller.params }
  cache_sweeper :resource_sweeper
  Model_class = QuizCollection.new.class
  # GET /quiz_center/quiz_collections
  # GET /quiz_center/quiz_collections.json
  def index
    @quiz_center_quiz_collections = QuizCollection.desc(:end_date).paginate(:page => params[:page])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), quiz_center_quiz_collections_path


    if stale? :etag => @quiz_center_quiz_collections
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @quiz_center_quiz_collections }
      end
    end
  end

  # GET /quiz_center/quiz_collections/1
  # GET /quiz_center/quiz_collections/1.json
  def show
    @quiz_center_quiz_collection = QuizCollection.find(params[:id])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), quiz_center_quiz_collection_path(@quiz_center_quiz_collection)

    if stale? :etag => [@quiz_center_quiz_collection]
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @quiz_center_quiz_collection }
      end
    end
  end

  # GET /quiz_center/quiz_collections/new
  # GET /quiz_center/quiz_collections/new.json
  def new
    @quiz_center_quiz_collection = QuizCollection.new
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_quiz_center_quiz_collection_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quiz_center_quiz_collection }
    end
  end

  # GET /quiz_center/quiz_collections/1/edit
  def edit
    @quiz_center_quiz_collection = QuizCollection.find(params[:id])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_quiz_center_quiz_collection_path(@quiz_center_quiz_collection)
  end

  # POST /quiz_center/quiz_collections
  # POST /quiz_center/quiz_collections.json
  def create

    @quiz_center_quiz_collection = QuizCollection.new(params[:quiz_collection])

    respond_to do |format|
      if @quiz_center_quiz_collection.save
        format.html { redirect_to [:quiz_center, @quiz_center_quiz_collection], notice: 'Quiz collection was successfully created.' }
        format.json { render json: @quiz_center_quiz_collection, status: :created, location: @quiz_center_quiz_collection }
      else
        format.html { render action: "new" }
        format.json { render json: @quiz_center_quiz_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quiz_center/quiz_collections/1
  # PUT /quiz_center/quiz_collections/1.json
  def update
    @quiz_center_quiz_collection = QuizCollection.find(params[:id])

    respond_to do |format|
      if @quiz_center_quiz_collection.update_attributes(params[:quiz_collection])
        format.html { redirect_to [:quiz_center, @quiz_center_quiz_collection], notice: 'Quiz collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quiz_center_quiz_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_center/quiz_collections/1
  # DELETE /quiz_center/quiz_collections/1.json
  def destroy
    @quiz_center_quiz_collection = QuizCollection.find(params[:id])
    @quiz_center_quiz_collection.destroy

    respond_to do |format|
      format.html { redirect_to quiz_center_quiz_collections_url }
      format.json { head :no_content }
    end
  end
end
