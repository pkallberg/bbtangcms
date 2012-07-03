require 'spec_helper'

describe "recommend/recommend_hindices/show" do
  before(:each) do
    @recommend_recommend_hindex = assign(:recommend_recommend_hindex, stub_model(Recommend::RecommendHindex,
      :name => "Name",
      :body => "MyText",
      :position => "Position",
      :color => "Color"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Position/)
    rendered.should match(/Color/)
  end
end
