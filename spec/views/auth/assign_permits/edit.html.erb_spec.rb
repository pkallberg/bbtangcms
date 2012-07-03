require 'spec_helper'

describe "auth/assign_permits/edit" do
  before(:each) do
    @auth_assign_permit = assign(:auth_assign_permit, stub_model(Auth::AssignPermit,
      :edit => "MyString",
      :show => "MyString",
      :index => "MyString"
    ))
  end

  it "renders the edit auth_assign_permit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => auth_assign_permits_path(@auth_assign_permit), :method => "post" do
      assert_select "input#auth_assign_permit_edit", :name => "auth_assign_permit[edit]"
      assert_select "input#auth_assign_permit_show", :name => "auth_assign_permit[show]"
      assert_select "input#auth_assign_permit_index", :name => "auth_assign_permit[index]"
    end
  end
end
