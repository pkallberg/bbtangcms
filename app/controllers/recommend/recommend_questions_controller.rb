class Recommend::RecommendQuestionsController < Recommend::RecommendBaseController
  load_and_authorize_resource  :class =>"Recommend::RecommendQuestion"
  Model_class = Recommend::RecommendQuestion.new.class
  # GET /recommend/recommend_questions
  # GET /recommend/recommend_questions.json
  def index
    @recommend_recommend_questions = Recommend::RecommendQuestion.paginate(:page => params[:page])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_questions_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_questions }
    end
  end

  # GET /recommend/recommend_questions/1
  # GET /recommend/recommend_questions/1.json
  def show
    @recommend_recommend_question = Recommend::RecommendQuestion.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_question_path(@recommend_recommend_question)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_question }
    end
  end

  # GET /recommend/recommend_questions/new
  # GET /recommend/recommend_questions/new.json
  def new
    @recommend_recommend_question = Recommend::RecommendQuestion.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_question_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_question }
    end
  end

  # GET /recommend/recommend_questions/1/edit
  def edit
    @recommend_recommend_question = Recommend::RecommendQuestion.find(params[:id])


    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_question_path(@recommend_recommend_question)
  end

  # POST /recommend/recommend_questions
  # POST /recommend/recommend_questions.json
  def create
    @recommend_recommend_question = Recommend::RecommendQuestion.new(params[:recommend_recommend_question])

    respond_to do |format|
      if @recommend_recommend_question.save
        format.html { redirect_to @recommend_recommend_question, notice: 'Recommend question was successfully created.' }
        format.json { render json: @recommend_recommend_question, status: :created, location: @recommend_recommend_question }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/recommend_questions/1
  # PUT /recommend/recommend_questions/1.json
  def update
    @recommend_recommend_question = Recommend::RecommendQuestion.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_question.update_attributes(params[:recommend_recommend_question])
        format.html { redirect_to @recommend_recommend_question, notice: 'Recommend question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_questions/1
  # DELETE /recommend/recommend_questions/1.json
  def destroy
    @recommend_recommend_question = Recommend::RecommendQuestion.find(params[:id])
    @recommend_recommend_question.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_questions_url }
      format.json { head :no_content }
    end
  end
end
