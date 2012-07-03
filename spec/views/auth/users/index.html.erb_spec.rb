require 'spec_helper'

describe "auth/users/index" do
  before(:each) do
    assign(:auth_users, [
      stub_model(Auth::User,
        :username => "Username",
        :email => "",
        :password => ""
      ),
      stub_model(Auth::User,
        :username => "Username",
        :email => "",
        :password => ""
      )
    ])
  end

  it "renders a list of auth/users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
