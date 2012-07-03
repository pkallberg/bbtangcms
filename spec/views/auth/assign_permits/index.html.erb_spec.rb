require 'spec_helper'

describe "auth/assign_permits/index" do
  before(:each) do
    assign(:auth_assign_permits, [
      stub_model(Auth::AssignPermit,
        :edit => "Edit",
        :show => "Show",
        :index => "Index"
      ),
      stub_model(Auth::AssignPermit,
        :edit => "Edit",
        :show => "Show",
        :index => "Index"
      )
    ])
  end

  it "renders a list of auth/assign_permits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Edit".to_s, :count => 2
    assert_select "tr>td", :text => "Show".to_s, :count => 2
    assert_select "tr>td", :text => "Index".to_s, :count => 2
  end
end
