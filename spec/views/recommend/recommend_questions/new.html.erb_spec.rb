require 'spec_helper'

describe "recommend/recommend_questions/new" do
  before(:each) do
    assign(:recommend_recommend_question, stub_model(Recommend::RecommendQuestion,
      :position => "MyString",
      :name => "MyString",
      :body => "MyText",
      :body_knowledge => "MyText"
    ).as_new_record)
  end

  it "renders new recommend_recommend_question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_questions_path, :method => "post" do
      assert_select "input#recommend_recommend_question_position", :name => "recommend_recommend_question[position]"
      assert_select "input#recommend_recommend_question_name", :name => "recommend_recommend_question[name]"
      assert_select "textarea#recommend_recommend_question_body", :name => "recommend_recommend_question[body]"
      assert_select "textarea#recommend_recommend_question_body_knowledge", :name => "recommend_recommend_question[body_knowledge]"
    end
  end
end
