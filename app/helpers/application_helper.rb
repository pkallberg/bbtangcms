# encoding: utf-8
module ApplicationHelper

  def render_page_title()
    default_title = "#{breadcrumbs.items.collect{|item| item.first}.join('>>')} | #{Setting.app_name}"
    if @page_title.present?
      @page_title ="#{@page_title}@" + default_title
    else
      @page_title = default_title
    end
    content_tag("title", @page_title, nil, false)
  end


  #set the title for the page
  def title(page_title)
    content_for(:title) do
       raw "<title>#{page_title} - #{Setting.app_name}</title>"
    end
  end
  #set the description for the page
  def description(page_description)
    content_for(:description) do
      raw "<meta name=\"description\" content=\"#{page_description}\" />\n"
    end
  end
  #set the keywords for the page
  def keywords(page_keywords)
    content_for(:keywords) do
      raw "<meta name=\"keywords\"  content=\"#{page_keywords}\" />\n"
    end
  end
  
  def change_ip_to_city(ip=nil)
    is = IpSearch.new
    ip ||= "116.228.214.170"
    is.find_ip_location(ip)
    #breakpoint
    #return is.country.gsub("市","")
    is.country.split("省").last.gsub("市","")
  end
end
