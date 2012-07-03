require 'spec_helper'

describe "auth/assign_permits/show" do
  before(:each) do
    @auth_assign_permit = assign(:auth_assign_permit, stub_model(Auth::AssignPermit,
      :edit => "Edit",
      :show => "Show",
      :index => "Index"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Edit/)
    rendered.should match(/Show/)
    rendered.should match(/Index/)
  end
end
