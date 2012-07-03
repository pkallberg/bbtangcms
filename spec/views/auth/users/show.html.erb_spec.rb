require 'spec_helper'

describe "auth/users/show" do
  before(:each) do
    @auth_user = assign(:auth_user, stub_model(Auth::User,
      :username => "Username",
      :email => "",
      :password => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Username/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
