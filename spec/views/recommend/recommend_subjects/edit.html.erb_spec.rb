require 'spec_helper'

describe "recommend/recommend_subjects/edit" do
  before(:each) do
    @recommend_recommend_subject = assign(:recommend_recommend_subject, stub_model(Recommend::RecommendSubject,
      :position => "MyString",
      :name => "MyString",
      :body => "MyText",
      :ids => "MyText"
    ))
  end

  it "renders the edit recommend_recommend_subject form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_subjects_path(@recommend_recommend_subject), :method => "post" do
      assert_select "input#recommend_recommend_subject_position", :name => "recommend_recommend_subject[position]"
      assert_select "input#recommend_recommend_subject_name", :name => "recommend_recommend_subject[name]"
      assert_select "textarea#recommend_recommend_subject_body", :name => "recommend_recommend_subject[body]"
      assert_select "textarea#recommend_recommend_subject_ids", :name => "recommend_recommend_subject[ids]"
    end
  end
end
