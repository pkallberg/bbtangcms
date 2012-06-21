require 'spec_helper'

describe "recommend/recommend_products/index" do
  before(:each) do
    assign(:recommend_recommend_products, [
      stub_model(Recommend::RecommendProduct,
        :position => "Position",
        :name => "Name",
        :image => "Image",
        :title => "Title",
        :price => 1.5,
        :cnt_buy => 1,
        :cnt_comment => 2,
        :link_url => "Link Url"
      ),
      stub_model(Recommend::RecommendProduct,
        :position => "Position",
        :name => "Name",
        :image => "Image",
        :title => "Title",
        :price => 1.5,
        :cnt_buy => 1,
        :cnt_comment => 2,
        :link_url => "Link Url"
      )
    ])
  end

  it "renders a list of recommend/recommend_products" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Link Url".to_s, :count => 2
  end
end
