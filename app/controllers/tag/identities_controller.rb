class Tag::IdentitiesController < Tag::TagBaseController
  load_and_authorize_resource
  Model_class = Identity.new.class
  # GET /tag/identities
  # GET /tag/identities.json
  def index
    @tag_identities = Identity.all

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), tag_identities_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tag_identities }
    end
  end

  # GET /tag/identities/1
  # GET /tag/identities/1.json
  def show
    @tag_identity = Identity.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), tag_identity_path(@tag_identity)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag_identity }
    end
  end

  # GET /tag/identities/new
  # GET /tag/identities/new.json
  def new
    @tag_identity = Identity.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_tag_identity_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag_identity }
    end
  end

  # GET /tag/identities/1/edit
  def edit
    @tag_identity = Identity.find(params[:id])
  end

  # POST /tag/identities
  # POST /tag/identities.json
  def create
    @tag_identity = Identity.new(params[:identity])

    respond_to do |format|
      if @tag_identity.save
        format.html { redirect_to tag_identity_path(@tag_identity), notice: 'Identity was successfully created.' }
        format.json { render json: @tag_identity, status: :created, location: @tag_identity }
      else
        format.html { render action: "new" }
        format.json { render json: @tag_identity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tag/identities/1
  # PUT /tag/identities/1.json
  def update
    @tag_identity = Identity.find(params[:id])

    respond_to do |format|
      if @tag_identity.update_attributes(params[:identity])
        format.html { redirect_to @tag_identity, notice: 'Identity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag_identity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag/identities/1
  # DELETE /tag/identities/1.json
  def destroy
    @tag_identity = Identity.find(params[:id])
    @tag_identity.destroy

    respond_to do |format|
      format.html { redirect_to tag_identities_url }
      format.json { head :no_content }
    end
  end
end
