class ArchivesController < ApplicationController
  def index
    @model_class = params[:model].constantize
    @categorybases = Categorybases.reversed_nested_set.all
    breadcrumbs.add I18n.t("helpers.titles.#{current_action}", :model => @model_class.model_name.human), archives_path(:model => @model_class)
    @knowledges = Knowledge.paginate(:page => params[:page], :per_page => 15)
  end
end
