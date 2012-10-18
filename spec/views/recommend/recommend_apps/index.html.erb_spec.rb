require 'spec_helper'

describe "recommend/recommend_apps/index" do
  before(:each) do
    assign(:recommend_recommend_apps, [
      stub_model(Recommend::RecommendApp,
        :name => "Name",
        :position => "MyText",
        :body => "Body"
      ),
      stub_model(Recommend::RecommendApp,
        :name => "Name",
        :position => "MyText",
        :body => "Body"
      )
    ])
  end

  it "renders a list of recommend/recommend_apps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
  end
end
