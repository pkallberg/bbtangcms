class Auth::AssignPermitsController < Auth::AuthBaseController
  authorize_resource :class => false
  Model_class = CuPermit.new.class
  # GET /auth/assign_permits
  # GET /auth/assign_permits.json
  def index
    #@auth_assign_permits = Auth::AssignPermit.all
    if current_user.admin_group?
      @admin_user = current_user

      breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), auth_assign_permits_path
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @admin_user }
      end
    end
  end

  # GET /auth/assign_permits/1
  # GET /auth/assign_permits/1.json
  def show
    #@auth_assign_permit = Auth::AssignPermit.find(params[:id])
    @owner_user = User.find(params[:id])
    if params["admin_group"]
      if current_user.owner_users(params["admin_group"]).include? @owner_user
        breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), auth_assign_permit_path(@owner_user)
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @owner_user }
    end
  end

  # GET /auth/assign_permits/new
  # GET /auth/assign_permits/new.json
  def new
    @auth_assign_permit = Auth::AssignPermit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @auth_assign_permit }
    end
  end

  # GET /auth/assign_permits/1/edit
  def edit
    #@auth_assign_permit = Auth::AssignPermit.find(params[:id])
    if current_user.admin_group?
      @admin_user = current_user
      @owner_user = User.find(params[:id])
      breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_auth_assign_permit_path(@owner_user)
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @admin_user }
      end
    end

  end

  # POST /auth/assign_permits
  # POST /auth/assign_permits.json
  def create
    @auth_assign_permit = Auth::AssignPermit.new(params[:auth_assign_permit])

    respond_to do |format|
      if @auth_assign_permit.save
        format.html { redirect_to @auth_assign_permit, notice: 'Assign permit was successfully created.' }
        format.json { render json: @auth_assign_permit, status: :created, location: @auth_assign_permit }
      else
        format.html { render action: "new" }
        format.json { render json: @auth_assign_permit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /auth/assign_permits/1
  # PUT /auth/assign_permits/1.json
  def update
    #@auth_assign_permit = Auth::AssignPermit.find(params[:id])
    if current_user.admin_group?
      @admin_user = current_user
      @owner_user = User.find(params[:id])

      respond_to do |format|
        if @owner_user.update_attributes(params[:user])
          format.html { redirect_to auth_assign_permit_path(@owner_user), notice: 'Assign permit was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @auth_assign_permit.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /auth/assign_permits/1
  # DELETE /auth/assign_permits/1.json
  def destroy
    if current_user.admin_group?
      @admin_user = current_user
      @owner_user = User.find(params[:id])
    #@auth_assign_permit = Auth::AssignPermit.find(params[:id])
    #@auth_assign_permit.destroy
      @owner_user.permits = []
      @owner_user.save
      respond_to do |format|
        format.html { redirect_to auth_assign_permits_url }
        format.json { head :no_content }
      end
    end
  end
end
