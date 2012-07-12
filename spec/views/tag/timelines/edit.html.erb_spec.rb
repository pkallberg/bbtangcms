require 'spec_helper'

describe "tag/timelines/edit" do
  before(:each) do
    @tag_timeline = assign(:tag_timeline, stub_model(Tag::Timeline,
      :name => "MyString",
      :parent_id => 1
    ))
  end

  it "renders the edit tag_timeline form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tag_timelines_path(@tag_timeline), :method => "post" do
      assert_select "input#tag_timeline_name", :name => "tag_timeline[name]"
      assert_select "input#tag_timeline_parent_id", :name => "tag_timeline[parent_id]"
    end
  end
end
