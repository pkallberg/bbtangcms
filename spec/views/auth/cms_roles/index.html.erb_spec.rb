require 'spec_helper'

describe "auth/cms_roles/index" do
  before(:each) do
    assign(:auth_cms_roles, [
      stub_model(Auth::CmsRole,
        :name => "Name",
        :role_permit => "",
        :assign_permit => ""
      ),
      stub_model(Auth::CmsRole,
        :name => "Name",
        :role_permit => "",
        :assign_permit => ""
      )
    ])
  end

  it "renders a list of auth/cms_roles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
