require 'spec_helper'

describe "recommend/recommend_products/show" do
  before(:each) do
    @recommend_recommend_product = assign(:recommend_recommend_product, stub_model(Recommend::RecommendProduct,
      :position => "Position",
      :name => "Name",
      :image => "Image",
      :title => "Title",
      :price => 1.5,
      :cnt_buy => 1,
      :cnt_comment => 2,
      :link_url => "Link Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Position/)
    rendered.should match(/Name/)
    rendered.should match(/Image/)
    rendered.should match(/Title/)
    rendered.should match(/1.5/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Link Url/)
  end
end
