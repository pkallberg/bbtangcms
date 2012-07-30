require 'spec_helper'

describe "attachments/index" do
  before(:each) do
    assign(:attachments, [
      stub_model(Attachment,
        :attachment_file_name => "Attachment File Name",
        :attachment_content_type => "Attachment Content Type",
        :attachment_file_size => "Attachment File Size",
        :purpose => "Purpose",
        :note => "MyText",
        :deleted_by_id => 1,
        :created_by_id => 2,
        :updated_by_id => 3
      ),
      stub_model(Attachment,
        :attachment_file_name => "Attachment File Name",
        :attachment_content_type => "Attachment Content Type",
        :attachment_file_size => "Attachment File Size",
        :purpose => "Purpose",
        :note => "MyText",
        :deleted_by_id => 1,
        :created_by_id => 2,
        :updated_by_id => 3
      )
    ])
  end

  it "renders a list of attachments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Attachment File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Attachment Content Type".to_s, :count => 2
    assert_select "tr>td", :text => "Attachment File Size".to_s, :count => 2
    assert_select "tr>td", :text => "Purpose".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
