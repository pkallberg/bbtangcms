require 'spec_helper'

describe "work/contacts/show" do
  before(:each) do
    @work_contact = assign(:work_contact, stub_model(Work::Contact))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
