require 'spec_helper'

describe "questions/show" do
  before(:each) do
    @question = assign(:question, stub_model(Question,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/false/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/MyText/)
    rendered.should match(/7/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
