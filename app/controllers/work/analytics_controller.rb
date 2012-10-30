class Work::AnalyticsController < Work::WorkBaseController
  include Work::AnalyticsHelper
  
  #authorize_resource :class => false
  before_filter :prepare
  
  # GET /work/analytics
  # GET /work/analytics.json
  def index
    if @models.present?
      @model = params[:model].present? ? params[:model].classify.constantize : @models.first
      session[:analytics_query_words] = nil
      session[:analytics_query_model] = nil
    end
    breadcrumbs.add ".work.analytics", work_analytics_path
  end

  def filter
    generate_date(model= params[:model], params_hash = params) 
    #@result_items = @model.where("#{@query_words}")
    session[:analytics_query_words] = @query_words if @query_words.present?
    session[:analytics_query_model] =  params[:model] if params[:model].present?
    
    @query_words = session[:analytics_query_words] if session[:analytics_query_words].present?
    @model = session[:analytics_query_model].classify.constantize if session[:analytics_query_model].present?

    @results = @model.where(@query_words).paginate(:page => params[:page]).order('id DESC')
    @model_class = @model
  end

  # GET /work/analytics/new
  # GET /work/analytics/new.json
  def new
    @work_analytic = Work::Analytic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @work_analytic }
    end
  end

  # GET /work/analytics/1/edit
  def edit
    @work_analytic = Work::Analytic.find(params[:id])
  end

  # POST /work/analytics
  # POST /work/analytics.json
  def create
    @work_analytic = Work::Analytic.new(params[:work_analytic])

    respond_to do |format|
      if @work_analytic.save
        format.html { redirect_to @work_analytic, notice: 'Analytic was successfully created.' }
        format.json { render json: @work_analytic, status: :created, location: @work_analytic }
      else
        format.html { render action: "new" }
        format.json { render json: @work_analytic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /work/analytics/1
  # PUT /work/analytics/1.json
  def update
    @work_analytic = Work::Analytic.find(params[:id])

    respond_to do |format|
      if @work_analytic.update_attributes(params[:work_analytic])
        format.html { redirect_to @work_analytic, notice: 'Analytic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @work_analytic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work/analytics/1
  # DELETE /work/analytics/1.json
  def destroy
    @work_analytic = Work::Analytic.find(params[:id])
    @work_analytic.destroy

    respond_to do |format|
      format.html { redirect_to work_analytics_url }
      format.json { head :no_content }
    end
  end
  
  private
  def prepare
    @model_list = %w(answer authorization note knowlege profile question user)
    @models = @model_list.collect{|m| m.classify.constantize if m.classify.class_exists?}.compact.uniq
    @col_types = [:string, :integer, :datetime]
  end
  
  def generate_date(model = nil, params_hash = {})
    if model.present?  
      @model = model.classify.constantize
      cols = Hash[model_col_type(@model)]
      @col_types.collect{|c| self.instance_variable_set("@#{c.to_s}_cols",cols.clone.keep_if{|k,v| v.eql? c})}
      #@string_cols = cols.clone.keep_if{|k,v| v.eql? :string}
      @query_words = ""
      @string_cols.each_key do |col|
        col_sql = ""
        if params_hash["#{@model.to_s.downcase}_#{col}"].present?
          if params_hash["#{@model.to_s.downcase}_#{col}_condition"].eql? "="
            col_sql << "#{col}" << " " << params_hash["#{@model.to_s.downcase}_#{col}_condition"] << " '" << params_hash["#{@model.to_s.downcase}_#{col}"] << "'"
          end
          if params_hash["#{@model.to_s.downcase}_#{col}_condition"].eql? "like"
            col_sql << "#{col}" << " " << params_hash["#{@model.to_s.downcase}_#{col}_condition"] << " " << "'%" << params_hash["#{@model.to_s.downcase}_#{col}"] << "%'"
          end
          relation = params_hash["#{@model.to_s.to_s.downcase}_#{col}_relation"]

          if relation.present? and params_hash["#{@model.to_s.downcase}_#{col}"].present?
            @query_words << ("(" << col_sql << ") #{relation} ")
          end
        end
      end

      [@datetime_cols,@integer_cols].each do |cols|
        cols.each_key do |col|
          col_sql = ""
          if params_hash["#{@model.to_s.downcase}_#{col}_begin"].present?
            col_sql << "#{col} " << params_hash["#{@model.to_s.downcase}_#{col}_begin_condition"] << " '" << params_hash["#{@model.to_s.downcase}_#{col}_begin"] << "'"
          end
          col_sql << " and " if params_hash["#{@model.to_s.downcase}_#{col}_begin"].present? and params_hash["#{@model.to_s.downcase}_#{col}_end"].present?
          if params_hash["#{@model.to_s.downcase}_#{col}_end"].present?
            col_sql << "#{col} " << params_hash["#{@model.to_s.downcase}_#{col}_end_condition"] << " '" << params_hash["#{@model.to_s.downcase}_#{col}_end"] << "'"
          end
          relation = params_hash["#{@model.to_s.to_s.downcase}_#{col}_relation"]
          if relation.present?  and  (params_hash["#{@model.to_s.downcase}_#{col}_begin"].present? or params_hash["#{@model.to_s.downcase}_#{col}_end"].present?)
            @query_words << ("(" << col_sql << ") #{relation} ")
          end
        end
      end

      @query_words = @query_words.strip.gsub(/and$|or$|AND$|OR$/,"").strip
    end
  end
end
