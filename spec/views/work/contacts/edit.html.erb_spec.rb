require 'spec_helper'

describe "work/contacts/edit" do
  before(:each) do
    @work_contact = assign(:work_contact, stub_model(Work::Contact))
  end

  it "renders the edit work_contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => work_contacts_path(@work_contact), :method => "post" do
    end
  end
end
