require 'spec_helper'

describe "recommend/recommend_others/index" do
  before(:each) do
    assign(:recommend_recommend_others, [
      stub_model(Recommend::RecommendOther,
        :recommend_other_type => "Recommend Other Type"
      ),
      stub_model(Recommend::RecommendOther,
        :recommend_other_type => "Recommend Other Type"
      )
    ])
  end

  it "renders a list of recommend/recommend_others" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Recommend Other Type".to_s, :count => 2
  end
end
