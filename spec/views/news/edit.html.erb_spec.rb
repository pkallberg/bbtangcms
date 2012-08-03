require 'spec_helper'

describe "news/edit" do
  before(:each) do
    @news = assign(:news, stub_model(News,
      :title => "MyString",
      :content => "MyText",
      :body => "MyText",
      :thanks_count => 1,
      :views_count => 1,
      :source_info => "MyString",
      :created_by_id => 1,
      :updated_by_id => 1,
      :deleted_by_id => 1
    ))
  end

  it "renders the edit news form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => news_index_path(@news), :method => "post" do
      assert_select "input#news_title", :name => "news[title]"
      assert_select "textarea#news_content", :name => "news[content]"
      assert_select "textarea#news_body", :name => "news[body]"
      assert_select "input#news_thanks_count", :name => "news[thanks_count]"
      assert_select "input#news_views_count", :name => "news[views_count]"
      assert_select "input#news_source_info", :name => "news[source_info]"
      assert_select "input#news_created_by_id", :name => "news[created_by_id]"
      assert_select "input#news_updated_by_id", :name => "news[updated_by_id]"
      assert_select "input#news_deleted_by_id", :name => "news[deleted_by_id]"
    end
  end
end
