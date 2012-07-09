require 'spec_helper'

describe "questions/index" do
  before(:each) do
    assign(:questions, [
      stub_model(Question,
        :title => "Title",
        :content => "MyText",
        :body => "MyText",
        :focus_by => "MyText",
        :created_by => 1,
        :views_count => 2,
        :delta => false,
        :best_answer_id => 3,
        :answers_count => 4,
        :experts_count => 5,
        :designated_answerer => 6,
        :auto_tags => "MyText",
        :knowledge_id => 7,
        :is_anonymous => false,
        :deleted => false
      ),
      stub_model(Question,
        :title => "Title",
        :content => "MyText",
        :body => "MyText",
        :focus_by => "MyText",
        :created_by => 1,
        :views_count => 2,
        :delta => false,
        :best_answer_id => 3,
        :answers_count => 4,
        :experts_count => 5,
        :designated_answerer => 6,
        :auto_tags => "MyText",
        :knowledge_id => 7,
        :is_anonymous => false,
        :deleted => false
      )
    ])
  end

  it "renders a list of questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
