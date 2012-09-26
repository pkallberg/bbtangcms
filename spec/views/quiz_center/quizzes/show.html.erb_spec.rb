require 'spec_helper'

describe "quiz_center/quizzes/show" do
  before(:each) do
    @quiz_center_quiz = assign(:quiz_center_quiz, stub_model(QuizCenter::Quiz,
      :title => "Title",
      :answer => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(//)
  end
end
