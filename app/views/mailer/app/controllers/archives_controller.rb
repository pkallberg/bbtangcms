# coding: utf-8
class ArchivesController < ApplicationController
  authorize_resource :class => false
  def index
    @model_class = params[:model].constantize
    breadcrumbs.add I18n.t("helpers.titles.archives", :model => @model_class.model_name.human), archives_path(:model => @model_class)
    @knowledges = Knowledge.paginate(:page => params[:page], :per_page => 15)
  end

  def savesort
    neworder = JSON.parse(params[:set])
    prev_item = nil
    neworder.each do |item|
      dbitem = Categorybases.find(item['id'])
      prev_item.nil? ? dbitem.move_to_root : dbitem.move_to_right_of(prev_item)
      sort_children(item, dbitem) unless item['children'].nil?
      prev_item = dbitem
    end
    Categorybases.rebuild!
    render :nothing => true
  end

  def sort_children(element,dbitem)
    prevchild = nil
    element['children'].each do |child|
      childitem = Categorybases.find(child['id'])
      prevchild.nil? ? childitem.move_to_child_of(dbitem) : childitem.move_to_right_of(prevchild)
      sort_children(child, childitem) unless child['children'].nil?
      prevchild = childitem
    end
  end
  def search_tag
    if (params.has_key? "model") and (params["model"].present?)
      @model_class = params[:model].constantize
      #query_word = params[:q]
      #@results = @model_class.where params[:type] => query_word
      # if params[:type].singularize.gsub("_id","").classify.class_exists?
      #if @results.empty?
      #  @results = @model_class.where("#{params[:type].to_s} like '%#{query_word}%'")
      #end
      search_tag = params[:search_tag].split(/，|,|;|；|\ +|\||\r\n/)
      @results = @model_class.tagged_with search_tag
    end

    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => @model_class.model_name.human), :search

    render :template => 'common/search_result.html.erb'
  end
  def item_list
    @model_class = params[:model].constantize
    @item = CategoryBase.find params[:item_id]
    @item_list = @model_class.tagged_with([@item.name]).order('id DESC')

    respond_to do |format|
      format.html # item_list.html.erb
      format.js
    end
  end
end
