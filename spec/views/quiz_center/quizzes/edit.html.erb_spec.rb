require 'spec_helper'

describe "quiz_center/quizzes/edit" do
  before(:each) do
    @quiz_center_quiz = assign(:quiz_center_quiz, stub_model(QuizCenter::Quiz,
      :title => "MyString",
      :answer => ""
    ))
  end

  it "renders the edit quiz_center_quiz form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => quiz_center_quizzes_path(@quiz_center_quiz), :method => "post" do
      assert_select "input#quiz_center_quiz_title", :name => "quiz_center_quiz[title]"
      assert_select "input#quiz_center_quiz_answer", :name => "quiz_center_quiz[answer]"
    end
  end
end
