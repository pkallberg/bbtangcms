class KnowledgesController < ApplicationController
  before_filter :authenticate_user!
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
    @identities=Identity.all
    @identities_choose=[]
    @timelines_choose=[]
    @timelines=[]
    @categories_choose=[]
    @categories=[]
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_knowledge_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @knowledge }
    end
  end

  # GET /knowledges/1/edit
  def edit
    @knowledge = Knowledge.find(params[:id])
    @identities=Identity.all
    @identities_choose=[]
    @timelines_choose=[]
    @timelines=[]
    @categories_choose=[]
    @categories=[]
    unless @knowledge.identities.empty?
      @knowledge.identities.each do |identity|
        identity = Identity.find_by_name(identity.name)
        @identities_choose.push(identity)
      end
    end

    unless @knowledge.timelines.empty?
      @knowledge.timelines.each do |timeline|
        #timeline = Timeline.find_by_name(timeline.name)
        Timeline.where(name:timeline.name).each do |t|
          @timelines_choose.push(t) if @identities_choose.include? t.parent
        end
      end
    end

    unless @knowledge.categories.empty?
      @knowledge.categories.each do |category|
        #category = Category.find_by_name(category.name)
        Category.where(name:category.name).each do |c|
          @categories_choose.push(c) if @timelines_choose.include? c.parent
        end
      end
    end
    #####################################
    unless @identities_choose.empty?
      @identities_choose.each do |identity|
        identity = Identity.find_by_name(identity.name)
        @timelines += identity.children.all
      end
    end
    

    unless @timelines_choose.empty?
      @timelines_choose.each do |timeline|
        #timeline = Timeline.find_by_name(timeline.name)
        #@categories += timeline.children.all
        Timeline.where(name:timeline.name).each do |t|
          @categories += t.children.all if @identities_choose.include? t.parent
        end
      end
    end

    #debugger
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_knowledge_path(@knowledge)
  end

  # POST /knowledges
  # POST /knowledges.json
  def create
    @knowledge = Knowledge.new(params[:knowledge])
    @identities=Identity.all
    @identities_choose=[]
    @timelines_choose=[]
    @timelines=[]
    @categories_choose=[]
    @categories=[]
    if params[:knowledge].has_key? "identity_list"
      params[:knowledge][:identity_list].each do |identity_id|
        if identity_id.present?
          @identities_choose.push(Identity.find(identity_id.to_i)) if Identity.find(identity_id.to_i)
        end
      end
    end
    if params[:knowledge].has_key? "timeline_list"
      params[:knowledge][:timeline_list].each do |timeline_id|
        if timeline_id.present?
          @timelines_choose.push(Timeline.find(timeline_id.to_i)) if Timeline.find(timeline_id.to_i)
        end
      end
    end
    if params[:knowledge].has_key? "category_list"
      params[:knowledge][:category_list].each do |category_id|
        if category_id.present?
          @categories_choose.push(Category.find(category_id.to_i)) if Category.find(category_id.to_i)
        end
      end
    end
    unless @identities_choose.empty?
      @identities_choose.each do |identities|
        @timelines += identities.children.all
      end
    end
    unless @timelines_choose.empty?
      @timelines_choose.each do |timeline|
        @categories += timeline.children.all if timeline.children.all
      end
    end

  if params[:commit] == 'refresh'
    #unless @timelines.empty?
    #  @timelines.each do |timelines|
    #    @categories_list += timeline.children.all
    #  end
    #end
    #@identities_choose.map!(&:id)
    #@timelines_choose.map!(&:id)
    #@categories_choose.map!(&:id)
    render :refresh
    else
      @knowledge.identity_list = @identities_choose.map(&:name) if not @identities_choose.empty?
      @knowledge.timeline_list = @timelines_choose.map(&:name) if not @timelines_choose.empty?
      @knowledge.category_list = @categories_choose.map(&:name) if not @categories_choose.empty?
      if @knowledge.save
        flash[:notice] = 'Knowledge was successfully updated.'
        render js: %[window.location.pathname='#{knowledge_path(@knowledge)}']
        #format.html { redirect_to @knowledge, notice: 'Knowledge was successfully created.' }
        #format.json { render json: @knowledge, status: :created, location: @knowledge }
      else
        respond_to do |format|
          format.html { render action: "new" }
          format.json { render json: @knowledge.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # PUT /knowledges/1
  # PUT /knowledges/1.json
  def update
    @knowledge = Knowledge.find(params[:id])
    #debugger
      @identities=Identity.all
      @identities_choose=[]
      @timelines_choose=[]
      @timelines=[]
      @categories_choose=[]
      @categories=[]
      if params[:knowledge].has_key? "identity_list"
        params[:knowledge][:identity_list].each do |identity_id|
          if identity_id.present?
            @identities_choose.push(Identity.find(identity_id.to_i)) if Identity.find(identity_id.to_i)
          end
        end
      end
      if params[:knowledge].has_key? "timeline_list"
        params[:knowledge][:timeline_list].each do |timeline_id|
          if timeline_id.present?
            @timelines_choose.push(Timeline.find(timeline_id.to_i)) if Timeline.find(timeline_id.to_i)
          end
        end
      end
      if params[:knowledge].has_key? "category_list"
        params[:knowledge][:category_list].each do |category_id|
          if category_id.present?
            @categories_choose.push(Category.find(category_id.to_i)) if Category.find(category_id.to_i)
          end
        end
      end
      unless @identities_choose.empty?
        @identities_choose.each do |identities|
          @timelines += identities.children.all
        end
      end
      unless @timelines_choose.empty?
        @timelines_choose.each do |timeline|
          @categories += timeline.children.all if timeline.children.all
        end
      end

    if params[:commit] == 'refresh'
      #unless @timelines.empty?
      #  @timelines.each do |timelines|
      #    @categories_list += timeline.children.all
      #  end
      #end
      #@identities_choose.map!(&:id)
      #@timelines_choose.map!(&:id)
      #@categories_choose.map!(&:id)
      render :refresh
    else
      params[:knowledge]["identity_list"] = @identities_choose.map(&:name) if not @identities_choose.empty?
      params[:knowledge]["timeline_list"] = @timelines_choose.map(&:name) if not @timelines_choose.empty?
      params[:knowledge]["category_list"] = @categories_choose.map(&:name) if not @categories_choose.empty?
      if @knowledge.update_attributes(params[:knowledge])
        #format.html { redirect_to @knowledge, notice: 'Knowledge was successfully updated.' }
        #format.json { head :no_content }
        flash[:notice] = 'Knowledge was successfully updated.'
        render js: %[window.location.pathname='#{knowledge_path(@knowledge)}']
      else
        respond_to do |format|
          format.html { render action: "edit" }
          format.json { render json: @knowledge.errors, status: :unprocessable_entity }
        end
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
