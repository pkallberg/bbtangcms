  #Customizing the Error Messages HTML
#ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
#  unless html_tag =~ /^<span/
#    %{<div class="field_with_errors">#{html_tag}<span for="#{instance.send(:tag_id)}" class="message">#{instance.error_message.first}</span></div>}.html_safe
#  else
#    %{#{html_tag}}.html_safe
#  end
#end