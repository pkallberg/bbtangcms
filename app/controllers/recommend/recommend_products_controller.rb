class Recommend::RecommendProductsController < Recommend::RecommendBaseController
  load_and_authorize_resource  :class =>"Recommend::RecommendProduct"
  Model_class = Recommend::RecommendProduct.new.class
  # GET /recommend/recommend_products
  # GET /recommend/recommend_products.json
  def index
    @recommend_recommend_products = Recommend::RecommendProduct.paginate(:page => params[:page])    

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_products_path
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recommend_recommend_products }
    end
  end

  # GET /recommend/recommend_products/1
  # GET /recommend/recommend_products/1.json
  def show
    @recommend_recommend_product = Recommend::RecommendProduct.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), recommend_recommend_product_path(@recommend_recommend_product)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recommend_recommend_product }
    end
  end

  # GET /recommend/recommend_products/new
  # GET /recommend/recommend_products/new.json
  def new
    @recommend_recommend_product = Recommend::RecommendProduct.new

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_recommend_recommend_product_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recommend_recommend_product }
    end
  end

  # GET /recommend/recommend_products/1/edit
  def edit
    @recommend_recommend_product = Recommend::RecommendProduct.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_recommend_recommend_product_path(@recommend_recommend_product)
  end

  # POST /recommend/recommend_products
  # POST /recommend/recommend_products.json
  def create
    @recommend_recommend_product = Recommend::RecommendProduct.new(params[:recommend_recommend_product])

    respond_to do |format|
      if @recommend_recommend_product.save
        format.html { redirect_to @recommend_recommend_product, notice: 'Recommend product was successfully created.' }
        format.json { render json: @recommend_recommend_product, status: :created, location: @recommend_recommend_product }
      else
        format.html { render action: "new" }
        format.json { render json: @recommend_recommend_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recommend/recommend_products/1
  # PUT /recommend/recommend_products/1.json
  def update
    @recommend_recommend_product = Recommend::RecommendProduct.find(params[:id])

    respond_to do |format|
      if @recommend_recommend_product.update_attributes(params[:recommend_recommend_product])
        format.html { redirect_to @recommend_recommend_product, notice: 'Recommend product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recommend_recommend_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommend/recommend_products/1
  # DELETE /recommend/recommend_products/1.json
  def destroy
    @recommend_recommend_product = Recommend::RecommendProduct.find(params[:id])
    @recommend_recommend_product.destroy

    respond_to do |format|
      format.html { redirect_to recommend_recommend_products_url }
      format.json { head :no_content }
    end
  end
end
