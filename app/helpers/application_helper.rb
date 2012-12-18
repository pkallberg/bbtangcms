# encoding: utf-8
module ApplicationHelper
=begin
def cache_helper(method_name, cache_params = {:expires_in => 30.minutes},*method_params);end
 => nil 
def cache_helper(method_name,*method_params,cache_params);end
=> nil 
=end
  # a common helper method to cache the return value of specil helper
  def cache_helper(method_name, cache_params = {:expires_in => 30.minutes},*method_params)
    cache_params = {:expires_in => 30.minutes} if cache_params.empty?
    
    if method_name.present? and self.respond_to? method_name
      cache_keys = "#{method_name}_" << method_params.collect{|v| "#{v}"}.join("&") << cache_params.collect{|k,v| "#{k.to_s}_#{v}"}.join("&")
      if Rails.cache.read("#{cache_keys}").nil?
        #send(:foo, *args)
        # same as: send(:foo, "abc")
        method_cache = self.send method_name, *method_params
        Rails.cache.write("#{cache_keys}" ,method_cache , cache_params)
      end
      Rails.cache.read("#{cache_keys}")
    else
      puts "no method defined #{method_name}, or something wrong unknow"
    end
  end
  
  #https://github.com/miketierney/artii/blob/master/spec/artii/base_spec.rb
  def asciify(content, args = {})
    if content.present?
      args = {:font => 'slant'} if args.empty?
      a = Artii::Base.new args
      a.asciify(content)
    end
  end
  
  def app_env
    <<-STRING
App Environments:
#{"-"*80}
#{"上海山缘网络科技有限公司".rjust(80)}
Ruby:  #{RUBY_VERSION}
Rails: #{Rails.version}
STRING
  end
  
  def ascii_logo
    <<-STRING
#{asciify(Setting.app_name)}
#{"="*80}
#{app_env}
STRING
  end
  
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
