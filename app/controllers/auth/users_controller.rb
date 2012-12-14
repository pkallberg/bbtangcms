class Auth::UsersController < Auth::AuthBaseController
  load_and_authorize_resource
  caches_action :index, :show, :public, :feed, :cache_path => Proc.new { |controller| controller.params }
  cache_sweeper :resource_sweeper
  
  Model_class = User.new.class
  # GET /auth/users
  # GET /auth/users.json
  def index
    #@auth_users = Auth::User.all
    if params[:conditions].present?
      @auth_users = User.where(params[:conditions]).paginate(:page => params[:page]).order('id DESC')
    else
      @auth_users= User.paginate(:page => params[:page]).order('id DESC')
    end

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), auth_users_path
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @auth_users }
    end
  end

  # GET /auth/users/1
  # GET /auth/users/1.json
  def show
    #@auth_user = Auth::User.find(params[:id])
    @auth_user = User.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), auth_user_path(@auth_user)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @auth_user }
    end
  end

  # GET /auth/users/new
  # GET /auth/users/new.json
  def new
    #@auth_user = Auth::User.new
    @auth_user = User.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_auth_user_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @auth_user }
    end
  end

  # GET /auth/users/1/edit
  def edit
    #@auth_user = Auth::User.find(params[:id])
    @auth_user = User.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_auth_user_path(@auth_user)
  end

  # POST /auth/users
  # POST /auth/users.json
  def create
    #@auth_user = Auth::User.new(params[:auth_user])
    @auth_user = User.new(params[:user])


    respond_to do |format|
      if @auth_user.save
        format.html { redirect_to auth_user_path(@auth_user), notice: 'User was successfully created.' }
        format.json { render json: @auth_user, status: :created, location: @auth_user }
      else
        format.html { render action: "new" }
        format.json { render json: @auth_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /auth/users/1
  # PUT /auth/users/1.json
  def update
    #@auth_user = Auth::User.find(params[:id])

    @auth_user = User.find(params[:id])
    @auth_user.update_user_permit(params[:user][:cms_role_ids]) if params[:user].key? :cms_role_ids
    respond_to do |format|
      if @auth_user.update_attributes(params[:user])

        format.html { redirect_to auth_user_path(@auth_user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @auth_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auth/users/1
  # DELETE /auth/users/1.json
  def destroy
    #@auth_user = Auth::User.find(params[:id])
    @auth_user = User.find(params[:id])
    @auth_user.destroy

    respond_to do |format|
      format.html { redirect_to auth_users_url }
      format.json { head :no_content }
    end
  end
end
