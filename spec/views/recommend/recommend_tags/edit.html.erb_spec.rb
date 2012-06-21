require 'spec_helper'

describe "recommend/recommend_tags/edit" do
  before(:each) do
    @recommend_recommend_tag = assign(:recommend_recommend_tag, stub_model(Recommend::RecommendTag,
      :position => "MyString",
      :name => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit recommend_recommend_tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_tags_path(@recommend_recommend_tag), :method => "post" do
      assert_select "input#recommend_recommend_tag_position", :name => "recommend_recommend_tag[position]"
      assert_select "input#recommend_recommend_tag_name", :name => "recommend_recommend_tag[name]"
      assert_select "textarea#recommend_recommend_tag_body", :name => "recommend_recommend_tag[body]"
    end
  end
end
