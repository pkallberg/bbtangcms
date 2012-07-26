class SubjectsController < ApplicationController
  load_and_authorize_resource
  Model_class = Subject.new.class

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.paginate(:page => params[:page])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), subjects_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subjects }
    end
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    @subject = Subject.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), subject_path(@subject)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subject }
    end
  end

  # GET /subjects/new
  # GET /subjects/new.json
  def new
    @subject = Subject.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_subject_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subject }
    end
  end

  # GET /subjects/1/edit
  def edit
    @subject = Subject.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_subject_path(@subject)
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(params[:subject])
    @subject.if_soft_deleted(params[:subject][:soft_deleted],current_user) if params[:subject][:soft_deleted].present?

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render json: @subject, status: :created, location: @subject }
      else
        format.html { render action: "new" }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subjects/1
  # PUT /subjects/1.json
  def update
    @subject = Subject.find(params[:id])
    @subject.if_soft_deleted(params[:subject][:soft_deleted],current_user) if params[:subject][:soft_deleted].present?

    respond_to do |format|
      if @subject.update_attributes(params[:subject])
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy

    respond_to do |format|
      format.html { redirect_to subjects_url }
      format.json { head :no_content }
    end
  end
end
