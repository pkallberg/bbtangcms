require 'spec_helper'

describe "recommend/recommend_subjects/new" do
  before(:each) do
    assign(:recommend_recommend_subject, stub_model(Recommend::RecommendSubject,
      :position => "MyString",
      :name => "MyString",
      :body => "MyText",
      :ids => "MyText"
    ).as_new_record)
  end

  it "renders new recommend_recommend_subject form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_subjects_path, :method => "post" do
      assert_select "input#recommend_recommend_subject_position", :name => "recommend_recommend_subject[position]"
      assert_select "input#recommend_recommend_subject_name", :name => "recommend_recommend_subject[name]"
      assert_select "textarea#recommend_recommend_subject_body", :name => "recommend_recommend_subject[body]"
      assert_select "textarea#recommend_recommend_subject_ids", :name => "recommend_recommend_subject[ids]"
    end
  end
end
