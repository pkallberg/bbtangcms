require 'spec_helper'

describe "recommend/recommend_tags/new" do
  before(:each) do
    assign(:recommend_recommend_tag, stub_model(Recommend::RecommendTag,
      :position => "MyString",
      :name => "MyString",
      :body => "MyText"
    ).as_new_record)
  end

  it "renders new recommend_recommend_tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_tags_path, :method => "post" do
      assert_select "input#recommend_recommend_tag_position", :name => "recommend_recommend_tag[position]"
      assert_select "input#recommend_recommend_tag_name", :name => "recommend_recommend_tag[name]"
      assert_select "textarea#recommend_recommend_tag_body", :name => "recommend_recommend_tag[body]"
    end
  end
end