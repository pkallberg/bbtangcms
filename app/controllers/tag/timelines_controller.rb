class Tag::TimelinesController < Tag::TagBaseController
  load_and_authorize_resource
  #load_resource :identity
  #load_and_authorize_resource :timeline, :through => [:identity], :shallow => true
  #load_and_authorize_resource :nested => :identity
  Model_class = Timeline.new.class
  before_filter :load_parent

  # GET /tag/timelines
  # GET /tag/timelines.json
  def index
    #@tag_timelines = Timeline.all
    @tag_timelines = @identity.children.paginate(:page => params[:page]).order('id DESC')

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), tag_identity_timelines_path(@identity)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tag_timelines }
    end
  end

  # GET /tag/timelines/1
  # GET /tag/timelines/1.json
  def show
    @tag_timeline = Timeline.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), tag_identity_timeline_path(@identity,@tag_timeline)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag_timeline }
    end
  end

  # GET /tag/timelines/new
  # GET /tag/timelines/new.json
  def new
    #@tag_timeline = @identity.children.new
    @tag_timeline = Timeline.new(parent_id: @identity.id)

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_tag_identity_timeline_path(@identity)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag_timeline }
    end
  end

  # GET /tag/timelines/1/edit
  def edit
    @tag_timeline = Timeline.find(params[:id])
  end

  # POST /tag/timelines
  # POST /tag/timelines.json
  def create
    @tag_timeline = Timeline.new(params[:timeline])
    @tag_timeline.parent_id = @identity.id if @identity.present?

    respond_to do |format|
      if @tag_timeline.save
        format.html { redirect_to tag_identity_timeline_path(@identity,@tag_timeline), notice: 'Timeline was successfully created.' }
        format.json { render json: @tag_timeline, status: :created, location: @tag_timeline }
      else
        format.html { render action: "new" }
        format.json { render json: @tag_timeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tag/timelines/1
  # PUT /tag/timelines/1.json
  def update
    @tag_timeline = Timeline.find(params[:id])
    @tag_timeline.parent_id = @identity.id if @identity.present?

    respond_to do |format|
      if @tag_timeline.update_attributes(params[:timeline])
        format.html { redirect_to @tag_timeline, notice: 'Timeline was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag_timeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag/timelines/1
  # DELETE /tag/timelines/1.json
  def destroy
    @tag_timeline = Timeline.find(params[:id])
    @tag_timeline.destroy

    respond_to do |format|
      format.html { redirect_to tag_timelines_url }
      format.json { head :no_content }
    end
  end
  private

    def load_parent

      @identity = Identity.find(params[:identity_id])
    end
end
