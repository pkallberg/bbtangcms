class AttachmentsController < ApplicationController
  load_and_authorize_resource
  caches_action :index, :feed, expires_in: 10.minutes, cache_path: Proc.new { |controller| current_user.present? ? controller.params.merge(user_id: current_user.id) : controller.params }
  caches_action :show, :public, expires_in: 1.hours, cache_path: Proc.new { |controller| current_user.present? ? controller.params.merge(user_id: current_user.id) : controller.params }
  cache_sweeper :resource_sweeper
  Model_class = Attachment.new.class
  # GET /attachments
  # GET /attachments.json
  def index
    @attachments = Attachment.paginate(:page => params[:page]).order('id DESC')

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), attachments_path

    if stale?  :etag => @attachments
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @attachments }
      end
    end
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
    @attachment = Attachment.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), attachment_path(@attachment)
    
    if stale?  :etag => @attachment
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @attachment }
      end
    end
  end

  # GET /attachments/new
  # GET /attachments/new.json
  def new
    @attachment = Attachment.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_attachment_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attachment }
    end
  end

  # GET /attachments/1/edit
  def edit
    @attachment = Attachment.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_attachment_path(@attachment)
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = Attachment.new(params[:attachment])
    @attachment.if_soft_deleted(params[:attachment][:soft_deleted],current_user) if params[:attachment][:soft_deleted].present?

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to @attachment, notice: 'Attachment was successfully created.' }
        format.json { render json: @attachment, status: :created, location: @attachment }
      else
        format.html { render action: "new" }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /attachments/1
  # PUT /attachments/1.json
  def update
    @attachment = Attachment.find(params[:id])
    @attachment.if_soft_deleted(params[:attachment][:soft_deleted],current_user) if params[:attachment][:soft_deleted].present?

    respond_to do |format|
      if @attachment.update_attributes(params[:attachment])
        format.html { redirect_to @attachment, notice: 'Attachment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to attachments_url }
      format.json { head :no_content }
    end
  end
end
