require 'spec_helper'

describe "quiz_center/quiz_collections/new" do
  before(:each) do
    assign(:quiz_center_quiz_collection, stub_model(QuizCenter::QuizCollection,
      :coll_name => "MyString",
      :quiz_ids => ""
    ).as_new_record)
  end

  it "renders new quiz_center_quiz_collection form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => quiz_center_quiz_collections_path, :method => "post" do
      assert_select "input#quiz_center_quiz_collection_coll_name", :name => "quiz_center_quiz_collection[coll_name]"
      assert_select "input#quiz_center_quiz_collection_quiz_ids", :name => "quiz_center_quiz_collection[quiz_ids]"
    end
  end
end
