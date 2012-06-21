require 'spec_helper'

describe "recommend/recommend_users/show" do
  before(:each) do
    @recommend_recommend_user = assign(:recommend_recommend_user, stub_model(Recommend::RecommendUser,
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
