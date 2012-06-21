require 'spec_helper'

describe "recommend/recommend_quizzes/show" do
  before(:each) do
    @recommend_recommend_quiz = assign(:recommend_recommend_quiz, stub_model(Recommend::RecommendQuiz,
      :position => "Position",
      :name => "Name",
      :body => "MyText",
      :ids => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Position/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
