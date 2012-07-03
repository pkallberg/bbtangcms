require 'spec_helper'

describe "auth/users/new" do
  before(:each) do
    assign(:auth_user, stub_model(Auth::User,
      :username => "MyString",
      :email => "",
      :password => ""
    ).as_new_record)
  end

  it "renders new auth_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => auth_users_path, :method => "post" do
      assert_select "input#auth_user_username", :name => "auth_user[username]"
      assert_select "input#auth_user_email", :name => "auth_user[email]"
      assert_select "input#auth_user_password", :name => "auth_user[password]"
    end
  end
end
