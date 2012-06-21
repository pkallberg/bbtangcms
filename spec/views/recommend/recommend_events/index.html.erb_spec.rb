require 'spec_helper'

describe "recommend/recommend_events/index" do
  before(:each) do
    assign(:recommend_recommend_events, [
      stub_model(Recommend::RecommendEvent,
        :position => "Position",
        :name => "Name",
        :body => "MyText"
      ),
      stub_model(Recommend::RecommendEvent,
        :position => "Position",
        :name => "Name",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of recommend/recommend_events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
