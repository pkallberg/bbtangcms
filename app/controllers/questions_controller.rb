require 'will_paginate/array'
class QuestionsController < ApplicationController
  load_and_authorize_resource
  caches_action :index, :show, :public, :feed, :cache_path => Proc.new { |controller| controller.params }
  cache_sweeper :resource_sweeper
  Model_class = Question.new.class
  before_filter :load_parent

  # GET /questions
  # GET /questions.json
  def index
    if @user.present?
      @questions = Question.where(created_by: @user.id).paginate(:page => params[:page]).order('created_at desc')
      breadcrumbs.add "#{@user}'s "+I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), questions_path(user_id: @user.id)
    else
      @questions = Question.paginate(:page => params[:page]).order('created_at desc')
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), questions_path
    end
    
    fresh_when :etag => [Model_class.last]
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), question_path(@question)
    
    fresh_when :etag => [@question]
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new
    @identities  = Identity.all
    @timelines = Timeline.all
    @categories   = Category.all

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), new_question_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    @identities  = Identity.all
    @timelines = []
    @categories = []

    @question_identities =  []
    if @question.identities.present?
      @question.identities.each do |identity|
        identity = Identity.find_by_name(identity.name)
        @question_identities.push(identity)
      end
    end

    @question_timelines = []
    @question.timelines.each do |timeline|
      #timeline = Timeline.find_by_name(timeline.name)
      Timeline.where(name: timeline.name).each do |t|
        @question_timelines.push(t) if @question_identities.include? t.parent
      end
    end

    @question_categories = []
      @question.categories.each do |category|
        #category = Category.find_by_name(category.name)
        Category.where(name: category.name).each do |c|
          @question_categories.push(c) if @question_timelines.include? c.parent
        end
      end

    if @question_identities.present?
      @question_identities.each do |identity|

        identity = Identity.find_by_name(identity.name)
        @timelines += identity.children.all if identity.present?
      end
    end

    if @question_timelines.present?
      @question_timelines.each do |timeline|
        Timeline.where(name: timeline.name).each do |t|
          @categories += t.children.all if @question_identities.include? t.parent
        end
      end
    end

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => Model_class.model_name.human), edit_question_path(@question)
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])
    @question.if_soft_deleted(params[:question][:soft_deleted],current_user) if params[:question][:soft_deleted].present?

    #params[:question][:identity_list].collect!{|i| Identity.find(i) if Identity.exists? i}.compact! if params[:question][:identity_list].present?
    #params[:question][:timeline_list].collect!{|t| Timeline.find(t) if Timeline.exists? t}.compact! if params[:question][:timeline_list].present?
    #params[:question][:category_list].collect!{|c| Category.find(c) if Category.exists? c}.compact! if params[:question][:category_list].present?
    params[:question][:identity_list] = Identity.find(params[:question][:identity_list]) if Identity.exists?  params[:question][:identity_list] if params[:question][:identity_list].present?
    params[:question][:timeline_list] = Timeline.find(params[:question][:timeline_list]) if Timeline.exists?  params[:question][:timeline_list] if params[:question][:timeline_list].present?
    params[:question][:category_list] = Category.find(params[:question][:category_list]) if Category.exists? params[:question][:category_list] if params[:question][:category_list].present?

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    #params[:question][:identity_list].collect!{|i| Identity.find(i) if Identity.exists? i}.compact! if params[:question][:identity_list].present?
    #params[:question][:timeline_list].collect!{|t| Timeline.find(t) if Timeline.exists? t}.compact! if params[:question][:timeline_list].present?
    #params[:question][:category_list].collect!{|c| Category.find(c) if Category.exists? c}.compact! if params[:question][:category_list].present?
    params[:question][:identity_list] = Identity.find(params[:question][:identity_list]) if Identity.exists?  params[:question][:identity_list] if params[:question][:identity_list].present?
    params[:question][:timeline_list] = Timeline.find(params[:question][:timeline_list]) if Timeline.exists?  params[:question][:timeline_list] if params[:question][:timeline_list].present?
    params[:question][:category_list] = Category.find(params[:question][:category_list]) if Category.exists? params[:question][:category_list] if params[:question][:category_list].present?

    @question.if_soft_deleted(params[:question][:soft_deleted],current_user) if params[:question][:soft_deleted].present?

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  #question_list = [1,2,3]
  def resetscore
    if params.has_key? :question_list
      question_list = params[:question_list]
      select_questions = Question.where id: question_list
    else
      select_questions = Question.all
    end

    select_questions.each do |question|
      question.score = 0
      question.save
    end

    redirect_to questions_url
  end

  def update_timelines
    # updates identity and timelines based on genre selected
    identity = Identity.find(params[:identity_id])
    @timelines = identity.children.all
    @categories = []

    #render :update_timelines do |page|
    #  page.replace_html 'timeline_list', :partial => 'timelines', :object => timelines
    #  page.replace_html 'category_list',   :partial => 'categories',   :object => categories
    #end
  end

  def update_categories
    # updates categories based on timeline selected
    timeline = Timeline.find(params[:timeline_id])
    @categories  = timeline.children.all

    #render :update_categories do |page|
    #  page.replace_html 'category_list', :partial => 'categories', :object => categories
    #end
  end

  private

    def load_parent
      @user = User.find(params[:user_id]) if params[:user_id].present?
    end
end
