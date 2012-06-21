require 'spec_helper'

describe "recommend/recommend_questions/show" do
  before(:each) do
    @recommend_recommend_question = assign(:recommend_recommend_question, stub_model(Recommend::RecommendQuestion,
      :position => "Position",
      :name => "Name",
      :body => "MyText",
      :body_knowledge => "MyText"
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
