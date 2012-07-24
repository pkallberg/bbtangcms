require 'spec_helper'

describe "recommend/recommend_ptags/edit" do
  before(:each) do
    @recommend_recommend_ptag = assign(:recommend_recommend_ptag, stub_model(Recommend::RecommendPtag,
      :name => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit recommend_recommend_ptag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_ptags_path(@recommend_recommend_ptag), :method => "post" do
      assert_select "input#recommend_recommend_ptag_name", :name => "recommend_recommend_ptag[name]"
      assert_select "textarea#recommend_recommend_ptag_body", :name => "recommend_recommend_ptag[body]"
    end
  end
end
