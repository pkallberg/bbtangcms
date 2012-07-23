class Recommend::RecommendEventsController < Recommend::RecommendBaseController
  load_and_authorize_resource  :class =>"Recommend::RecommendEvent"
  Model_class = Recommend::RecommendEvent.new.class
  # GET /recommend/recommend_events
  # GET /recommend/recommend_events.json
  def index
    @recommend_recommend_events = Recommend::RecommendEvent.all.entries

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_events_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_events }
    end
  end

  # GET /recommend/recommend_events/1
  # GET /recommend/recommend_events/1.json
  def show
    @recommend_recommend_event = Recommend::RecommendEvent.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_event_path(@recommend_recommend_event)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_event }
    end
  end

  # GET /recommend/recommend_events/new
  # GET /recommend/recommend_events/new.json
  def new
    @recommend_recommend_event = Recommend::RecommendEvent.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_event_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_event }
    end
  end

  # GET /recommend/recommend_events/1/edit
  def edit
    @recommend_recommend_event = Recommend::RecommendEvent.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_event_path(@recommend_recommend_event)
  end

  # POST /recommend/recommend_events
  # POST /recommend/recommend_events.json
  def create
    @recommend_recommend_event = Recommend::RecommendEvent.new(params[:recommend_recommend_event])

    respond_to do |format|
      if @recommend_recommend_event.save
        format.html { redirect_to @recommend_recommend_event, notice: 'Recommend event was successfully created.' }
        format.json { render json: @recommend_recommend_event, status: :created, location: @recommend_recommend_event }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/recommend_events/1
  # PUT /recommend/recommend_events/1.json
  def update
    @recommend_recommend_event = Recommend::RecommendEvent.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_event.update_attributes(params[:recommend_recommend_event])
        format.html { redirect_to @recommend_recommend_event, notice: 'Recommend event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_events/1
  # DELETE /recommend/recommend_events/1.json
  def destroy
    @recommend_recommend_event = Recommend::RecommendEvent.find(params[:id])
    @recommend_recommend_event.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_events_url }
      format.json { head :no_content }
    end
  end
end
