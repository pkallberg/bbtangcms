require 'spec_helper'

describe "attachments/show" do
  before(:each) do
    @attachment = assign(:attachment, stub_model(Attachment,
      :attachment_file_name => "Attachment File Name",
      :attachment_content_type => "Attachment Content Type",
      :attachment_file_size => "Attachment File Size",
      :purpose => "Purpose",
      :note => "MyText",
      :deleted_by_id => 1,
      :created_by_id => 2,
      :updated_by_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Attachment File Name/)
    rendered.should match(/Attachment Content Type/)
    rendered.should match(/Attachment File Size/)
    rendered.should match(/Purpose/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
