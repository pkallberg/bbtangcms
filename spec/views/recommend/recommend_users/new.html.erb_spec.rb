require 'spec_helper'

describe "recommend/recommend_users/new" do
  before(:each) do
    assign(:recommend_recommend_user, stub_model(Recommend::RecommendUser,
      :position => "MyString",
      :name => "MyString",
      :body => "MyText"
    ).as_new_record)
  end

  it "renders new recommend_recommend_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_users_path, :method => "post" do
      assert_select "input#recommend_recommend_user_position", :name => "recommend_recommend_user[position]"
      assert_select "input#recommend_recommend_user_name", :name => "recommend_recommend_user[name]"
      assert_select "textarea#recommend_recommend_user_body", :name => "recommend_recommend_user[body]"
    end
  end
end
