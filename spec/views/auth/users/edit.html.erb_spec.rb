require 'spec_helper'

describe "auth/users/edit" do
  before(:each) do
    @auth_user = assign(:auth_user, stub_model(Auth::User,
      :username => "MyString",
      :email => "",
      :password => ""
    ))
  end

  it "renders the edit auth_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => auth_users_path(@auth_user), :method => "post" do
      assert_select "input#auth_user_username", :name => "auth_user[username]"
      assert_select "input#auth_user_email", :name => "auth_user[email]"
      assert_select "input#auth_user_password", :name => "auth_user[password]"
    end
  end
end
