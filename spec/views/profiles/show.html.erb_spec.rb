require 'spec_helper'

describe "profiles/show" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :user_id => 1,
      :real_name => "Real Name",
      :nickname => "Nickname",
      :level_id => 2,
      :gender => false,
      :face => "",
      :degree => "Degree",
      :city => "City",
      :phone => "",
      :baby_gender => 3,
      :profession => "Profession",
      :expert_field => "MyText",
      :hobby => "Hobby",
      :focus_tags_on => "MyText",
      :pregnancy_status => 4,
      :agerange => 5,
      :pregnancy_timeline => 6,
      :label => "Label",
      :weibo => "Weibo"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Real Name/)
    rendered.should match(/Nickname/)
    rendered.should match(/2/)
    rendered.should match(/false/)
    rendered.should match(//)
    rendered.should match(/Degree/)
    rendered.should match(/City/)
    rendered.should match(//)
    rendered.should match(/3/)
    rendered.should match(/Profession/)
    rendered.should match(/MyText/)
    rendered.should match(/Hobby/)
    rendered.should match(/MyText/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/Label/)
    rendered.should match(/Weibo/)
  end
end
