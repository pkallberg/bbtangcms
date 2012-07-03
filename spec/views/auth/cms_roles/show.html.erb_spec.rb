require 'spec_helper'

describe "auth/cms_roles/show" do
  before(:each) do
    @auth_cms_role = assign(:auth_cms_role, stub_model(Auth::CmsRole,
      :name => "Name",
      :role_permit => "",
      :assign_permit => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
