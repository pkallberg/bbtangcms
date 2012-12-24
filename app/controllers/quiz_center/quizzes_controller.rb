class QuizCenter::QuizzesController < QuizCenter::QuizCenterBaseController
  load_and_authorize_resource
  caches_action :index, :feed, expires_in: 10.minutes, cache_path: Proc.new { |controller| current_user.present? ? controller.params.merge(user_id: current_user.id) : controller.params }
  caches_action :show, :public, expires_in: 1.hours, cache_path: Proc.new { |controller| current_user.present? ? controller.params.merge(user_id: current_user.id) : controller.params }
  cache_sweeper :resource_sweeper
  Model_class = Quiz.new.class
  before_filter :load_parent
  # GET /quiz_center/quizzes
  # GET /quiz_center/quizzes.json
  def index
    if @quiz_collection.present?
      @quiz_center_quizzes = @quiz_collection.quizzes
      breadcrumbs.add "#{@quiz_collection}'s "+I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), quiz_center_quizzes_path(quiz_collection_id: @quiz_collection.id)
    else
      @quiz_center_quizzes = Quiz.paginate(:page => params[:page]).order('id DESC')
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), quiz_center_quizzes_path
    end
    
    if stale?  :etag => @quiz_center_quizzes
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @quiz_center_quizzes }
      end
    end
  end

  # GET /quiz_center/quizzes/1
  # GET /quiz_center/quizzes/1.json
  def show
    @quiz_center_quiz = Quiz.find(params[:id])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), quiz_center_quiz_path(@quiz_center_quiz)
    
    if stale?  :etag => @quiz_center_quiz
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @quiz_center_quiz }
      end
    end
  end

  # GET /quiz_center/quizzes/new
  # GET /quiz_center/quizzes/new.json
  def new
    @quiz_center_quiz = Quiz.new
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_quiz_center_quiz_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quiz_center_quiz }
    end
  end

  # GET /quiz_center/quizzes/1/edit
  def edit
    @quiz_center_quiz = Quiz.find(params[:id])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_quiz_center_quiz_path(@quiz_center_quiz)

  end

  # POST /quiz_center/quizzes
  # POST /quiz_center/quizzes.json
  def create
    @quiz_center_quiz = Quiz.new(params[:quiz])

    respond_to do |format|
      if @quiz_center_quiz.save
        format.html { redirect_to [:quiz_center,@quiz_center_quiz], notice: 'Quiz was successfully created.' }
        format.json { render json: @quiz_center_quiz, status: :created, location: @quiz_center_quiz }
      else
        format.html { render action: "new" }
        format.json { render json: @quiz_center_quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quiz_center/quizzes/1
  # PUT /quiz_center/quizzes/1.json
  def update
    @quiz_center_quiz = Quiz.find(params[:id])

    respond_to do |format|
      if @quiz_center_quiz.update_attributes(params[:quiz])
        format.html { redirect_to [:quiz_center,@quiz_center_quiz], notice: 'Quiz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quiz_center_quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_center/quizzes/1
  # DELETE /quiz_center/quizzes/1.json
  def destroy
    @quiz_center_quiz = Quiz.find(params[:id])
    @quiz_center_quiz.destroy

    respond_to do |format|
      format.html { redirect_to quiz_center_quizzes_url }
      format.json { head :no_content }
    end
  end

  private

    def load_parent
      @quiz_collection = QuizCollection.find(params[:quiz_collection_id]) if params[:quiz_collection_id].present?
    end
end
