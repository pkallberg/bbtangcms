require 'spec_helper'

describe "auth/cms_roles/new" do
  before(:each) do
    assign(:auth_cms_role, stub_model(Auth::CmsRole,
      :name => "MyString",
      :role_permit => "",
      :assign_permit => ""
    ).as_new_record)
  end

  it "renders new auth_cms_role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => auth_cms_roles_path, :method => "post" do
      assert_select "input#auth_cms_role_name", :name => "auth_cms_role[name]"
      assert_select "input#auth_cms_role_role_permit", :name => "auth_cms_role[role_permit]"
      assert_select "input#auth_cms_role_assign_permit", :name => "auth_cms_role[assign_permit]"
    end
  end
end
