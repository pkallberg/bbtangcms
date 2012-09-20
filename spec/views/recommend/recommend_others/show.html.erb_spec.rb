require 'spec_helper'

describe "recommend/recommend_others/show" do
  before(:each) do
    @recommend_recommend_other = assign(:recommend_recommend_other, stub_model(Recommend::RecommendOther,
      :recommend_other_type => "Recommend Other Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Recommend Other Type/)
  end
end
