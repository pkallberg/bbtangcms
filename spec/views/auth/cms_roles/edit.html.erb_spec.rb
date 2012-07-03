require 'spec_helper'

describe "auth/cms_roles/edit" do
  before(:each) do
    @auth_cms_role = assign(:auth_cms_role, stub_model(Auth::CmsRole,
      :name => "MyString",
      :role_permit => "",
      :assign_permit => ""
    ))
  end

  it "renders the edit auth_cms_role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => auth_cms_roles_path(@auth_cms_role), :method => "post" do
      assert_select "input#auth_cms_role_name", :name => "auth_cms_role[name]"
      assert_select "input#auth_cms_role_role_permit", :name => "auth_cms_role[role_permit]"
      assert_select "input#auth_cms_role_assign_permit", :name => "auth_cms_role[assign_permit]"
    end
  end
end
