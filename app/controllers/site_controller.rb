class SiteController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :set_breadcrumb

  def about
  end

  def changelog
  end

  def license
  end

  def policies
  end

  def team
  end

  def support
  end

  private
  def set_breadcrumb
    breadcrumbs.add I18n.t("breadcrumbs.site.#{current_action}"), self.send("site_#{current_action}_path") if self.respond_to? "site_#{current_action}_path"
  end
end
