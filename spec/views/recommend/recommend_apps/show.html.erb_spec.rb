require 'spec_helper'

describe "recommend/recommend_apps/show" do
  before(:each) do
    @recommend_recommend_app = assign(:recommend_recommend_app, stub_model(Recommend::RecommendApp,
      :name => "Name",
      :position => "MyText",
      :body => "Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Body/)
  end
end
