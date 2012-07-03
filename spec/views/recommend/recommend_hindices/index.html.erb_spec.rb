require 'spec_helper'

describe "recommend/recommend_hindices/index" do
  before(:each) do
    assign(:recommend_recommend_hindices, [
      stub_model(Recommend::RecommendHindex,
        :name => "Name",
        :body => "MyText",
        :position => "Position",
        :color => "Color"
      ),
      stub_model(Recommend::RecommendHindex,
        :name => "Name",
        :body => "MyText",
        :position => "Position",
        :color => "Color"
      )
    ])
  end

  it "renders a list of recommend/recommend_hindices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
  end
end
