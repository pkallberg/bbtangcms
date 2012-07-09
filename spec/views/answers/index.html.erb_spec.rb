require 'spec_helper'

describe "answers/index" do
  before(:each) do
    assign(:answers, [
      stub_model(Answer,
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
      ),
      stub_model(Answer,
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
      )
    ])
  end

  it "renders a list of answers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
