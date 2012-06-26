require 'spec_helper'

describe "profiles/index" do
  before(:each) do
    assign(:profiles, [
      stub_model(Profile,
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
      ),
      stub_model(Profile,
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
      )
    ])
  end

  it "renders a list of profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Real Name".to_s, :count => 2
    assert_select "tr>td", :text => "Nickname".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Degree".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Profession".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Hobby".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "Label".to_s, :count => 2
    assert_select "tr>td", :text => "Weibo".to_s, :count => 2
  end
end
