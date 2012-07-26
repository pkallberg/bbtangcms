class Recommend::RecommendSubjectsController < Recommend::RecommendBaseController
  load_and_authorize_resource  :class =>"Recommend::RecommendSubject"
  Model_class = Recommend::RecommendSubject.new.class
  # GET /recommend/recommend_subjects
  # GET /recommend/recommend_subjects.json
  def index
    @recommend_recommend_subjects = Recommend::RecommendSubject.all.entries

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_subjects_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_subjects }
    end
  end

  # GET /recommend/recommend_subjects/1
  # GET /recommend/recommend_subjects/1.json
  def show
    @recommend_recommend_subject = Recommend::RecommendSubject.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_subject_path(@recommend_recommend_subject)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_subject }
    end
  end

  # GET /recommend/recommend_subjects/new
  # GET /recommend/recommend_subjects/new.json
  def new
    @recommend_recommend_subject = Recommend::RecommendSubject.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_subject_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_subject }
    end
  end

  # GET /recommend/recommend_subjects/1/edit
  def edit
    @recommend_recommend_subject = Recommend::RecommendSubject.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_subject_path(@recommend_recommend_subject)
  end

  # POST /recommend/recommend_subjects
  # POST /recommend/recommend_subjects.json
  def create
    @recommend_recommend_subject = Recommend::RecommendSubject.new(params[:recommend_recommend_subject])

    respond_to do |format|
      if @recommend_recommend_subject.save
        format.html { redirect_to @recommend_recommend_subject, notice: 'Recommend subject was successfully created.' }
        format.json { render json: @recommend_recommend_subject, status: :created, location: @recommend_recommend_subject }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/recommend_subjects/1
  # PUT /recommend/recommend_subjects/1.json
  def update
    @recommend_recommend_subject = Recommend::RecommendSubject.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_subject.update_attributes(params[:recommend_recommend_subject])
        format.html { redirect_to @recommend_recommend_subject, notice: 'Recommend subject was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_subjects/1
  # DELETE /recommend/recommend_subjects/1.json
  def destroy
    @recommend_recommend_subject = Recommend::RecommendSubject.find(params[:id])
    @recommend_recommend_subject.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_subjects_url }
      format.json { head :no_content }
    end
  end
end
