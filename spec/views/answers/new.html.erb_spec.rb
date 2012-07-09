require 'spec_helper'

describe "answers/new" do
  before(:each) do
    assign(:answer, stub_model(Answer,
      :content => "MyText",
      :body => "MyText",
      :created_by => 1,
      :question_id => 1,
      :opposition_count => 1,
      :opposition_ids => 1,
      :approval_count => 1,
      :approval_ids => 1,
      :expert_count => 1,
      :deleted_by => 1,
      :is_anonymous => false,
      :no_help_count => 1,
      :no_help_ids => "MyText",
      :delta => false,
      :state => "MyString",
      :is_expert => false
    ).as_new_record)
  end

  it "renders new answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => answers_path, :method => "post" do
      assert_select "textarea#answer_content", :name => "answer[content]"
      assert_select "textarea#answer_body", :name => "answer[body]"
      assert_select "input#answer_created_by", :name => "answer[created_by]"
      assert_select "input#answer_question_id", :name => "answer[question_id]"
      assert_select "input#answer_opposition_count", :name => "answer[opposition_count]"
      assert_select "input#answer_opposition_ids", :name => "answer[opposition_ids]"
      assert_select "input#answer_approval_count", :name => "answer[approval_count]"
      assert_select "input#answer_approval_ids", :name => "answer[approval_ids]"
      assert_select "input#answer_expert_count", :name => "answer[expert_count]"
      assert_select "input#answer_deleted_by", :name => "answer[deleted_by]"
      assert_select "input#answer_is_anonymous", :name => "answer[is_anonymous]"
      assert_select "input#answer_no_help_count", :name => "answer[no_help_count]"
      assert_select "textarea#answer_no_help_ids", :name => "answer[no_help_ids]"
      assert_select "input#answer_delta", :name => "answer[delta]"
      assert_select "input#answer_state", :name => "answer[state]"
      assert_select "input#answer_is_expert", :name => "answer[is_expert]"
    end
  end
end
