require 'spec_helper'

describe "auth/assign_permits/new" do
  before(:each) do
    assign(:auth_assign_permit, stub_model(Auth::AssignPermit,
      :edit => "MyString",
      :show => "MyString",
      :index => "MyString"
    ).as_new_record)
  end

  it "renders new auth_assign_permit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => auth_assign_permits_path, :method => "post" do
      assert_select "input#auth_assign_permit_edit", :name => "auth_assign_permit[edit]"
      assert_select "input#auth_assign_permit_show", :name => "auth_assign_permit[show]"
      assert_select "input#auth_assign_permit_index", :name => "auth_assign_permit[index]"
    end
  end
end
