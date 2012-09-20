require 'spec_helper'

describe "recommend/recommend_others/edit" do
  before(:each) do
    @recommend_recommend_other = assign(:recommend_recommend_other, stub_model(Recommend::RecommendOther,
      :recommend_other_type => "MyString"
    ))
  end

  it "renders the edit recommend_recommend_other form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_others_path(@recommend_recommend_other), :method => "post" do
      assert_select "input#recommend_recommend_other_recommend_other_type", :name => "recommend_recommend_other[recommend_other_type]"
    end
  end
end
