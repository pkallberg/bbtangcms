require 'spec_helper'

describe "tag/timelines/new" do
  before(:each) do
    assign(:tag_timeline, stub_model(Tag::Timeline,
      :name => "MyString",
      :parent_id => 1
    ).as_new_record)
  end

  it "renders new tag_timeline form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tag_timelines_path, :method => "post" do
      assert_select "input#tag_timeline_name", :name => "tag_timeline[name]"
      assert_select "input#tag_timeline_parent_id", :name => "tag_timeline[parent_id]"
    end
  end
end
