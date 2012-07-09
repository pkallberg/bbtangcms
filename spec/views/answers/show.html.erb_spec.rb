require 'spec_helper'

describe "answers/show" do
  before(:each) do
    @answers = assign(:answers, stub_model(Answers,
      :content => "MyText",
      :body => "MyText",
      :created_by => 1,
      :question_id => 2,
      :opposition_count => 3,
      :opposition_ids => 4,
      :approval_count => 5,
      :approval_ids => 6,
      :expert_count => 7,
      :deleted_by => 8,
      :is_anonymous => false,
      :no_help_count => 9,
      :no_help_ids => "MyText",
      :delta => false,
      :state => "State",
      :is_expert => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/7/)
    rendered.should match(/8/)
    rendered.should match(/false/)
    rendered.should match(/9/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
    rendered.should match(/State/)
    rendered.should match(/false/)
  end
end
