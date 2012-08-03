require 'spec_helper'

describe "news/index" do
  before(:each) do
    assign(:news, [
      stub_model(News,
        :title => "Title",
        :content => "MyText",
        :body => "MyText",
        :thanks_count => 1,
        :views_count => 2,
        :source_info => "Source Info",
        :created_by_id => 3,
        :updated_by_id => 4,
        :deleted_by_id => 5
      ),
      stub_model(News,
        :title => "Title",
        :content => "MyText",
        :body => "MyText",
        :thanks_count => 1,
        :views_count => 2,
        :source_info => "Source Info",
        :created_by_id => 3,
        :updated_by_id => 4,
        :deleted_by_id => 5
      )
    ])
  end

  it "renders a list of news" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Source Info".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
