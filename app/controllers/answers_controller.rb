class AnswersController < ApplicationController
  load_and_authorize_resource
  Model_class = Answer.new.class

  before_filter :load_parent
  # GET /answers
  # GET /answers.json
  def index
    #@answers = Answer.all
    @answers = @question.answer.paginate(:page => params[:page], :per_page => 20).order('id DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    #@answer = Answer.find(params[:id])
    @answer = @question.answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.json
  def new
    #@answer = Answer.new
    @answer = @question.answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    #@answer = Answer.find(params[:id])
    @answer = @question.answer.find(params[:id])
  end

  # POST /answers
  # POST /answers.json
  def create
    #@answer = Answer.new(params[:answer])
    @answer = @question.answer.new(params[:answer])
    @answer.if_soft_deleted(current_user) if params[:answer][:soft_deleted].present?

    respond_to do |format|
      if @answer.save
        format.html { redirect_to [@question,@answer], notice: 'Answer was successfully created.' }
        format.json { render json: @answer, status: :created, location: @answer }
      else
        format.html { render action: "new" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.json
  def update
    #@answer = Answer.find(params[:id])
    @answer = @question.answer.find(params[:id])
    @answer.if_soft_deleted(current_user) if params[:answer][:soft_deleted].present?

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to [@question,@answer], notice: 'Answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    #@answer = Answer.find(params[:id])
    @answer = @question.answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to question_answers_url(@question) }
      format.json { head :no_content }
    end
  end

  private

    def load_parent
      @question = Question.find(params[:question_id])
    end
end
