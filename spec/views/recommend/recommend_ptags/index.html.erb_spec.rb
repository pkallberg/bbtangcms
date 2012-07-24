require 'spec_helper'

describe "recommend/recommend_ptags/index" do
  before(:each) do
    assign(:recommend_recommend_ptags, [
      stub_model(Recommend::RecommendPtag,
        :name => "Name",
        :body => "MyText"
      ),
      stub_model(Recommend::RecommendPtag,
        :name => "Name",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of recommend/recommend_ptags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
