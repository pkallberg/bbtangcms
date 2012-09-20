class Recommend::OtherColumnsController < ApplicationController
  load_and_authorize_resource  :class =>"Recommend::OtherColumn"
  Model_class = Recommend::OtherColumn.new.class
  # GET /recommend/other_columns
  # GET /recommend/other_columns.json
  def index
    @recommend_other_columns = Recommend::OtherColumn.all

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_other_columns_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_other_columns }
    end
  end

  # GET /recommend/other_columns/1
  # GET /recommend/other_columns/1.json
  def show
    @recommend_other_column = Recommend::OtherColumn.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_other_column_path(@recommend_other_column)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_other_column }
    end
  end

  # GET /recommend/other_columns/new
  # GET /recommend/other_columns/new.json
  def new
    @recommend_other_column = Recommend::OtherColumn.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_other_column_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_other_column }
    end
  end

  # GET /recommend/other_columns/1/edit
  def edit
    @recommend_other_column = Recommend::OtherColumn.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_other_column_path(@recommend_other_column)
  end

  # POST /recommend/other_columns
  # POST /recommend/other_columns.json
  def create
    @recommend_other_column = Recommend::OtherColumn.new(params[:recommend_other_column])

    respond_to do |format|
      if @recommend_other_column.save
        format.html { redirect_to @recommend_other_column, notice: 'Other column was successfully created.' }
        format.json { render json: @recommend_other_column, status: :created, location: @recommend_other_column }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_other_column.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/other_columns/1
  # PUT /recommend/other_columns/1.json
  def update
    @recommend_other_column = Recommend::OtherColumn.find(params[:id])

    respond_to do |format|
      if @recommend_other_column.update_attributes(params[:recommend_other_column])
        format.html { redirect_to @recommend_other_column, notice: 'Other column was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_other_column.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/other_columns/1
  # DELETE /recommend/other_columns/1.json
  def destroy
    @recommend_other_column = Recommend::OtherColumn.find(params[:id])
    @recommend_other_column.destroy

    respond_to do |format|
      format.html { redirect_to recommend_other_columns_url }
      format.json { head :no_content }
    end
  end
end
