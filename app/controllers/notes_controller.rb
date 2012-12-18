class NotesController < ApplicationController
  load_and_authorize_resource
  caches_action :index, :show, :public, :feed, :cache_path => Proc.new { |controller| controller.params }
  cache_sweeper :resource_sweeper

  Model_class = Note.new.class

  before_filter :load_parent

  # GET /notes
  # GET /notes.json
  def index
    if @user.present?
      @notes = Note.where(created_by: @user.id).paginate(:page => params[:page]).order('id DESC')
      breadcrumbs.add "#{@user}'s "+I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), notes_path(user_id: @user.id)
    else
      @notes = Note.paginate(:page => params[:page]).order('id DESC')
      breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), notes_path
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), note_path(@note)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

=begin
  # GET /notes/new
  # GET /notes/new.json
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end
=end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_note_path(@note)
  end

=begin
  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(params[:note])

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private

    def load_parent
      @user = User.find(params[:user_id]) if params[:user_id].present?
    end
end
