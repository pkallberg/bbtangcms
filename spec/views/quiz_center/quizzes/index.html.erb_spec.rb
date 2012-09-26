require 'spec_helper'

describe "quiz_center/quizzes/index" do
  before(:each) do
    assign(:quiz_center_quizzes, [
      stub_model(QuizCenter::Quiz,
        :title => "Title",
        :answer => ""
      ),
      stub_model(QuizCenter::Quiz,
        :title => "Title",
        :answer => ""
      )
    ])
  end

  it "renders a list of quiz_center/quizzes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
