class KnowledgesController < ApplicationController
  Model_class = Knowledge.new.class

  # GET /knowledges
  # GET /knowledges.json
  def index
    @knowledges = Knowledge.paginate(:page => params[:page], :per_page => 15)
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), knowledges_path
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @knowledges }
    end
  end

  # GET /knowledges/1
  # GET /knowledges/1.json
  def show
    @knowledge = Knowledge.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), knowledge_path(@knowledge)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @knowledge }
    end
  end

  # GET /knowledges/new
  # GET /knowledges/new.json
  def new
    @knowledge = Knowledge.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_knowledge_path(@knowledge)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @knowledge }
    end
  end

  # GET /knowledges/1/edit
  def edit
    @knowledge = Knowledge.find(params[:id])
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_knowledge_path(@knowledge)
  end

  # POST /knowledges
  # POST /knowledges.json
  def create
    @knowledge = Knowledge.new(params[:knowledge])

    respond_to do |format|
      if @knowledge.save
        format.html { redirect_to @knowledge, notice: 'Knowledge was successfully created.' }
        format.json { render json: @knowledge, status: :created, location: @knowledge }
      else
        format.html { render action: "new" }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /knowledges/1
  # PUT /knowledges/1.json
  def update
    @knowledge = Knowledge.find(params[:id])

    respond_to do |format|
      if @knowledge.update_attributes(params[:knowledge])
        format.html { redirect_to @knowledge, notice: 'Knowledge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /knowledges/1
  # DELETE /knowledges/1.json
  def destroy
    @knowledge = Knowledge.find(params[:id])
    @knowledge.destroy

    respond_to do |format|
      format.html { redirect_to knowledges_url }
      format.json { head :no_content }
    end
  end
end
