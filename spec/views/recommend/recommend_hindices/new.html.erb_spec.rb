require 'spec_helper'

describe "recommend/recommend_hindices/new" do
  before(:each) do
    assign(:recommend_recommend_hindex, stub_model(Recommend::RecommendHindex,
      :name => "MyString",
      :body => "MyText",
      :position => "MyString",
      :color => "MyString"
    ).as_new_record)
  end

  it "renders new recommend_recommend_hindex form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_hindices_path, :method => "post" do
      assert_select "input#recommend_recommend_hindex_name", :name => "recommend_recommend_hindex[name]"
      assert_select "textarea#recommend_recommend_hindex_body", :name => "recommend_recommend_hindex[body]"
      assert_select "input#recommend_recommend_hindex_position", :name => "recommend_recommend_hindex[position]"
      assert_select "input#recommend_recommend_hindex_color", :name => "recommend_recommend_hindex[color]"
    end
  end
end
