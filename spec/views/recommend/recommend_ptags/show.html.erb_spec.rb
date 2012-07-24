require 'spec_helper'

describe "recommend/recommend_ptags/show" do
  before(:each) do
    @recommend_recommend_ptag = assign(:recommend_recommend_ptag, stub_model(Recommend::RecommendPtag,
      :name => "Name",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
