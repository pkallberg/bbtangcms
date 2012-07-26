require 'spec_helper'

describe "subjects/index" do
  before(:each) do
    assign(:subjects, [
      stub_model(Subject,
        :title => "Title",
        :title2 => "Title2",
        :summary => "MyText",
        :content => "MyText",
        :body => "MyText",
        :category => 1,
        :sort_index => 2,
        :releated_ids => 3,
        :created_by => 4,
        :updated_by => 5,
        :deleted_by_id => 6
      ),
      stub_model(Subject,
        :title => "Title",
        :title2 => "Title2",
        :summary => "MyText",
        :content => "MyText",
        :body => "MyText",
        :category => 1,
        :sort_index => 2,
        :releated_ids => 3,
        :created_by => 4,
        :updated_by => 5,
        :deleted_by_id => 6
      )
    ])
  end

  it "renders a list of subjects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Title2".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
