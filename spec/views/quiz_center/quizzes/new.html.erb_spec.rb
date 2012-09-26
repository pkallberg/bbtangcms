require 'spec_helper'

describe "quiz_center/quizzes/new" do
  before(:each) do
    assign(:quiz_center_quiz, stub_model(QuizCenter::Quiz,
      :title => "MyString",
      :answer => ""
    ).as_new_record)
  end

  it "renders new quiz_center_quiz form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => quiz_center_quizzes_path, :method => "post" do
      assert_select "input#quiz_center_quiz_title", :name => "quiz_center_quiz[title]"
      assert_select "input#quiz_center_quiz_answer", :name => "quiz_center_quiz[answer]"
    end
  end
end
