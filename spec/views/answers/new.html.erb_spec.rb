require 'spec_helper'

describe "answers/new" do
  before(:each) do
    assign(:answers, stub_model(Answers,
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

  it "renders new answers form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => answers_index_path, :method => "post" do
      assert_select "textarea#answers_content", :name => "answers[content]"
      assert_select "textarea#answers_body", :name => "answers[body]"
      assert_select "input#answers_created_by", :name => "answers[created_by]"
      assert_select "input#answers_question_id", :name => "answers[question_id]"
      assert_select "input#answers_opposition_count", :name => "answers[opposition_count]"
      assert_select "input#answers_opposition_ids", :name => "answers[opposition_ids]"
      assert_select "input#answers_approval_count", :name => "answers[approval_count]"
      assert_select "input#answers_approval_ids", :name => "answers[approval_ids]"
      assert_select "input#answers_expert_count", :name => "answers[expert_count]"
      assert_select "input#answers_deleted_by", :name => "answers[deleted_by]"
      assert_select "input#answers_is_anonymous", :name => "answers[is_anonymous]"
      assert_select "input#answers_no_help_count", :name => "answers[no_help_count]"
      assert_select "textarea#answers_no_help_ids", :name => "answers[no_help_ids]"
      assert_select "input#answers_delta", :name => "answers[delta]"
      assert_select "input#answers_state", :name => "answers[state]"
      assert_select "input#answers_is_expert", :name => "answers[is_expert]"
    end
  end
end
