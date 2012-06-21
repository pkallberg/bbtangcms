require 'spec_helper'

describe "recommend/recommend_mtools/show" do
  before(:each) do
    @recommend_recommend_mtool = assign(:recommend_recommend_mtool, stub_model(Recommend::RecommendMtool,
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
