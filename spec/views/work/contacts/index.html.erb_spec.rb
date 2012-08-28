require 'spec_helper'

describe "work/contacts/index" do
  before(:each) do
    assign(:work_contacts, [
      stub_model(Work::Contact),
      stub_model(Work::Contact)
    ])
  end

  it "renders a list of work/contacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
