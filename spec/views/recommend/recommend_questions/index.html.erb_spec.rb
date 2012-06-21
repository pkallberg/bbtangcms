require 'spec_helper'

describe "recommend/recommend_questions/index" do
  before(:each) do
    assign(:recommend_recommend_questions, [
      stub_model(Recommend::RecommendQuestion,
        :position => "Position",
        :name => "Name",
        :body => "MyText",
        :body_knowledge => "MyText"
      ),
      stub_model(Recommend::RecommendQuestion,
        :position => "Position",
        :name => "Name",
        :body => "MyText",
        :body_knowledge => "MyText"
      )
    ])
  end

  it "renders a list of recommend/recommend_questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
