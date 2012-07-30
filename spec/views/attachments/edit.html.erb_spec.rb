require 'spec_helper'

describe "attachments/edit" do
  before(:each) do
    @attachment = assign(:attachment, stub_model(Attachment,
      :attachment_file_name => "MyString",
      :attachment_content_type => "MyString",
      :attachment_file_size => "MyString",
      :purpose => "MyString",
      :note => "MyText",
      :deleted_by_id => 1,
      :created_by_id => 1,
      :updated_by_id => 1
    ))
  end

  it "renders the edit attachment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => attachments_path(@attachment), :method => "post" do
      assert_select "input#attachment_attachment_file_name", :name => "attachment[attachment_file_name]"
      assert_select "input#attachment_attachment_content_type", :name => "attachment[attachment_content_type]"
      assert_select "input#attachment_attachment_file_size", :name => "attachment[attachment_file_size]"
      assert_select "input#attachment_purpose", :name => "attachment[purpose]"
      assert_select "textarea#attachment_note", :name => "attachment[note]"
      assert_select "input#attachment_deleted_by_id", :name => "attachment[deleted_by_id]"
      assert_select "input#attachment_created_by_id", :name => "attachment[created_by_id]"
      assert_select "input#attachment_updated_by_id", :name => "attachment[updated_by_id]"
    end
  end
end
