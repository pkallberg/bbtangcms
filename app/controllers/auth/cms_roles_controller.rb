class Auth::CmsRolesController < Auth::AuthBaseController
  load_and_authorize_resource
  caches_action :index, :show, :public, :feed, :cache_path => Proc.new { |controller| current_user.present? ? controller.params.merge(user_id: current_user.id) : controller.params }
  cache_sweeper :resource_sweeper
  
  Model_class = CmsRole.new.class
  # GET /auth/cms_roles
  # GET /auth/cms_roles.json
  def index
    @auth_cms_roles = CmsRole.paginate(:page => params[:page]).order('id DESC')

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), auth_cms_roles_path
    
    if stale?  :etag => @auth_cms_roles
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @auth_cms_roles }
      end
    end
  end

  # GET /auth/cms_roles/1
  # GET /auth/cms_roles/1.json
  def show
    @auth_cms_role = CmsRole.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), auth_cms_role_path(@auth_cms_role)
    
    if stale?  :etag => @auth_cms_role
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @auth_cms_role }
      end
    end
  end

  # GET /auth/cms_roles/new
  # GET /auth/cms_roles/new.json
  def new
    @auth_cms_role = CmsRole.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_auth_cms_role_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @auth_cms_role }
    end
  end

  # GET /auth/cms_roles/1/edit
  def edit
    @auth_cms_role = CmsRole.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_auth_cms_role_path(@auth_cms_role)
  end

  # POST /auth/cms_roles
  # POST /auth/cms_roles.json
  def create
    @auth_cms_role = CmsRole.new(params[:cms_role])

    respond_to do |format|
      if @auth_cms_role.save
        format.html { redirect_to auth_cms_role_path(@auth_cms_role), notice: 'Cms role was successfully created.' }
        format.json { render json: @auth_cms_role, status: :created, location: @auth_cms_role }
      else
        format.html { render action: "new" }
        format.json { render json: @auth_cms_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /auth/cms_roles/1
  # PUT /auth/cms_roles/1.json
  def update
    @auth_cms_role = CmsRole.find(params[:id])
    @auth_cms_role.set_cms_role_permits_list(params["cms_role"]["cms_role_permit_ids"]) if params["cms_role"]["cms_role_permit_ids"].present?
    @auth_cms_role.set_assign_permits_list(params["cms_role"]["assign_permit_ids"]) if params["cms_role"]["assign_permit_ids"].present?

    @auth_cms_role.name = params["cms_role"]["name"]

    respond_to do |format|
      if @auth_cms_role.save
        format.html { redirect_to auth_cms_role_path(@auth_cms_role), notice: 'Cms role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @auth_cms_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auth/cms_roles/1
  # DELETE /auth/cms_roles/1.json
  def destroy
    @auth_cms_role = CmsRole.find(params[:id])
    @auth_cms_role.destroy

    respond_to do |format|
      format.html { redirect_to auth_cms_roles_url }
      format.json { head :no_content }
    end
  end
end
