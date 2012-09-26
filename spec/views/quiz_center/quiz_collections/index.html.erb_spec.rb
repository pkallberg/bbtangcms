require 'spec_helper'

describe "quiz_center/quiz_collections/index" do
  before(:each) do
    assign(:quiz_center_quiz_collections, [
      stub_model(QuizCenter::QuizCollection,
        :coll_name => "Coll Name",
        :quiz_ids => ""
      ),
      stub_model(QuizCenter::QuizCollection,
        :coll_name => "Coll Name",
        :quiz_ids => ""
      )
    ])
  end

  it "renders a list of quiz_center/quiz_collections" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Coll Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
