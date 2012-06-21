require 'spec_helper'

describe "recommend/recommend_quizzes/new" do
  before(:each) do
    assign(:recommend_recommend_quiz, stub_model(Recommend::RecommendQuiz,
      :position => "MyString",
      :name => "MyString",
      :body => "MyText",
      :ids => "MyText"
    ).as_new_record)
  end

  it "renders new recommend_recommend_quiz form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_recommend_quizzes_path, :method => "post" do
      assert_select "input#recommend_recommend_quiz_position", :name => "recommend_recommend_quiz[position]"
      assert_select "input#recommend_recommend_quiz_name", :name => "recommend_recommend_quiz[name]"
      assert_select "textarea#recommend_recommend_quiz_body", :name => "recommend_recommend_quiz[body]"
      assert_select "textarea#recommend_recommend_quiz_ids", :name => "recommend_recommend_quiz[ids]"
    end
  end
end
