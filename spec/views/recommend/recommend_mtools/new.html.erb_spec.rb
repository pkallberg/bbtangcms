require 'spec_helper'

describe "recommend/recommend_mtools/new" do
  before(:each) do
    assign(:recommend_recommend_mtool, stub_model(Recommend::RecommendMtool,
      :position => "MyString",
      :name => "MyString",
      :body => "MyText"
    ).as_new_record)
  end

  it "renders new recommend_recommend_mtool form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_mtools_path, :method => "post" do
      assert_select "input#recommend_recommend_mtool_position", :name => "recommend_recommend_mtool[position]"
      assert_select "input#recommend_recommend_mtool_name", :name => "recommend_recommend_mtool[name]"
      assert_select "textarea#recommend_recommend_mtool_body", :name => "recommend_recommend_mtool[body]"
    end
  end
end
