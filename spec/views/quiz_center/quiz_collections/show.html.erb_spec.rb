require 'spec_helper'

describe "quiz_center/quiz_collections/show" do
  before(:each) do
    @quiz_center_quiz_collection = assign(:quiz_center_quiz_collection, stub_model(QuizCenter::QuizCollection,
      :coll_name => "Coll Name",
      :quiz_ids => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Coll Name/)
    rendered.should match(//)
  end
end
