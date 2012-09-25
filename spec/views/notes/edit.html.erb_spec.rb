require 'spec_helper'

describe "notes/edit" do
  before(:each) do
    @note = assign(:note, stub_model(Note,
      :title => "MyString",
      :content => "MyText",
      :body => "MyText",
      :tags_list => "MyString"
    ))
  end

  it "renders the edit note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notes_path(@note), :method => "post" do
      assert_select "input#note_title", :name => "note[title]"
      assert_select "textarea#note_content", :name => "note[content]"
      assert_select "textarea#note_body", :name => "note[body]"
      assert_select "input#note_tags_list", :name => "note[tags_list]"
    end
  end
end
