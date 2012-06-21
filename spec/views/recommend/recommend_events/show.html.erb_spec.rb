require 'spec_helper'

describe "recommend/recommend_events/show" do
  before(:each) do
    @recommend_recommend_event = assign(:recommend_recommend_event, stub_model(Recommend::RecommendEvent,
      :position => "Position",
      :name => "Name",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Position/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
