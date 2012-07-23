class Recommend::RecommendQuizzesController < Recommend::RecommendBaseController
  load_and_authorize_resource  :class =>"Recommend::RecommendQuiz"
  Model_class = Recommend::RecommendQuiz.new.class
  # GET /recommend/recommend_quizzes
  # GET /recommend/recommend_quizzes.json
  def index
    @recommend_recommend_quizzes = Recommend::RecommendQuiz.all

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_quizzes_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_quizzes }
    end
  end

  # GET /recommend/recommend_quizzes/1
  # GET /recommend/recommend_quizzes/1.json
  def show
    @recommend_recommend_quiz = Recommend::RecommendQuiz.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_quiz_path(@recommend_recommend_quiz)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_quiz }
    end
  end

  # GET /recommend/recommend_quizzes/new
  # GET /recommend/recommend_quizzes/new.json
  def new
    @recommend_recommend_quiz = Recommend::RecommendQuiz.new


    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_quiz_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_quiz }
    end
  end

  # GET /recommend/recommend_quizzes/1/edit
  def edit
    @recommend_recommend_quiz = Recommend::RecommendQuiz.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_quiz_path(@recommend_recommend_quiz)
  end

  # POST /recommend/recommend_quizzes
  # POST /recommend/recommend_quizzes.json
  def create
    @recommend_recommend_quiz = Recommend::RecommendQuiz.new(params[:recommend_recommend_quiz])

    respond_to do |format|
      if @recommend_recommend_quiz.save
        format.html { redirect_to @recommend_recommend_quiz, notice: 'Recommend quiz was successfully created.' }
        format.json { render json: @recommend_recommend_quiz, status: :created, location: @recommend_recommend_quiz }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/recommend_quizzes/1
  # PUT /recommend/recommend_quizzes/1.json
  def update
    @recommend_recommend_quiz = Recommend::RecommendQuiz.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_quiz.update_attributes(params[:recommend_recommend_quiz])
        format.html { redirect_to @recommend_recommend_quiz, notice: 'Recommend quiz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_quizzes/1
  # DELETE /recommend/recommend_quizzes/1.json
  def destroy
    @recommend_recommend_quiz = Recommend::RecommendQuiz.find(params[:id])
    @recommend_recommend_quiz.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_quizzes_url }
      format.json { head :no_content }
    end
  end
end
