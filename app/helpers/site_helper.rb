module SiteHelper
  def changelog
    content=File.open("#{Rails.root}/ChangeLog.markdown","r"){ |file| file.read }
    RDiscount.new(content).to_html if content.present?
  end
  def license
    content=File.open("#{Rails.root}/LICENSE","r"){ |file| file.read }
    RDiscount.new(content).to_html if content.present?
  end
end
