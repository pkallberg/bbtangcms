require 'spec_helper'

describe "questions/edit" do
  before(:each) do
    @question = assign(:question, stub_model(Question,
      :title => "MyString",
      :content => "MyText",
      :body => "MyText",
      :focus_by => "MyText",
      :created_by => 1,
      :views_count => 1,
      :delta => false,
      :best_answer_id => 1,
      :answers_count => 1,
      :experts_count => 1,
      :designated_answerer => 1,
      :auto_tags => "MyText",
      :knowledge_id => 1,
      :is_anonymous => false,
      :deleted => false
    ))
  end

  it "renders the edit question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => questions_path(@question), :method => "post" do
      assert_select "input#question_title", :name => "question[title]"
      assert_select "textarea#question_content", :name => "question[content]"
      assert_select "textarea#question_body", :name => "question[body]"
      assert_select "textarea#question_focus_by", :name => "question[focus_by]"
      assert_select "input#question_created_by", :name => "question[created_by]"
      assert_select "input#question_views_count", :name => "question[views_count]"
      assert_select "input#question_delta", :name => "question[delta]"
      assert_select "input#question_best_answer_id", :name => "question[best_answer_id]"
      assert_select "input#question_answers_count", :name => "question[answers_count]"
      assert_select "input#question_experts_count", :name => "question[experts_count]"
      assert_select "input#question_designated_answerer", :name => "question[designated_answerer]"
      assert_select "textarea#question_auto_tags", :name => "question[auto_tags]"
      assert_select "input#question_knowledge_id", :name => "question[knowledge_id]"
      assert_select "input#question_is_anonymous", :name => "question[is_anonymous]"
      assert_select "input#question_deleted", :name => "question[deleted]"
    end
  end
end
