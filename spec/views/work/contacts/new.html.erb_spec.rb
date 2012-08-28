require 'spec_helper'

describe "work/contacts/new" do
  before(:each) do
    assign(:work_contact, stub_model(Work::Contact).as_new_record)
  end

  it "renders new work_contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => work_contacts_path, :method => "post" do
    end
  end
end
