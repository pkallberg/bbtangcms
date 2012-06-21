require 'spec_helper'

describe "recommend/recommend_mtools/edit" do
  before(:each) do
    @recommend_recommend_mtool = assign(:recommend_recommend_mtool, stub_model(Recommend::RecommendMtool,
      :position => "MyString",
      :name => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit recommend_recommend_mtool form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_mtools_path(@recommend_recommend_mtool), :method => "post" do
      assert_select "input#recommend_recommend_mtool_position", :name => "recommend_recommend_mtool[position]"
      assert_select "input#recommend_recommend_mtool_name", :name => "recommend_recommend_mtool[name]"
      assert_select "textarea#recommend_recommend_mtool_body", :name => "recommend_recommend_mtool[body]"
    end
  end
end
