require 'spec_helper'

describe "recommend/recommend_apps/new" do
  before(:each) do
    assign(:recommend_recommend_app, stub_model(Recommend::RecommendApp,
      :name => "MyString",
      :position => "MyText",
      :body => "MyString"
    ).as_new_record)
  end

  it "renders new recommend_recommend_app form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_apps_path, :method => "post" do
      assert_select "input#recommend_recommend_app_name", :name => "recommend_recommend_app[name]"
      assert_select "textarea#recommend_recommend_app_position", :name => "recommend_recommend_app[position]"
      assert_select "input#recommend_recommend_app_body", :name => "recommend_recommend_app[body]"
    end
  end
end
