require 'spec_helper'

describe "profiles/edit" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :user_id => 1,
      :real_name => "MyString",
      :nickname => "MyString",
      :level_id => 1,
      :gender => false,
      :face => "",
      :degree => "MyString",
      :city => "MyString",
      :phone => "",
      :baby_gender => 1,
      :profession => "MyString",
      :expert_field => "MyText",
      :hobby => "MyString",
      :focus_tags_on => "MyText",
      :pregnancy_status => 1,
      :agerange => 1,
      :pregnancy_timeline => 1,
      :label => "MyString",
      :weibo => "MyString"
    ))
  end

  it "renders the edit profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => profiles_path(@profile), :method => "post" do
      assert_select "input#profile_user_id", :name => "profile[user_id]"
      assert_select "input#profile_real_name", :name => "profile[real_name]"
      assert_select "input#profile_nickname", :name => "profile[nickname]"
      assert_select "input#profile_level_id", :name => "profile[level_id]"
      assert_select "input#profile_gender", :name => "profile[gender]"
      assert_select "input#profile_face", :name => "profile[face]"
      assert_select "input#profile_degree", :name => "profile[degree]"
      assert_select "input#profile_city", :name => "profile[city]"
      assert_select "input#profile_phone", :name => "profile[phone]"
      assert_select "input#profile_baby_gender", :name => "profile[baby_gender]"
      assert_select "input#profile_profession", :name => "profile[profession]"
      assert_select "textarea#profile_expert_field", :name => "profile[expert_field]"
      assert_select "input#profile_hobby", :name => "profile[hobby]"
      assert_select "textarea#profile_focus_tags_on", :name => "profile[focus_tags_on]"
      assert_select "input#profile_pregnancy_status", :name => "profile[pregnancy_status]"
      assert_select "input#profile_agerange", :name => "profile[agerange]"
      assert_select "input#profile_pregnancy_timeline", :name => "profile[pregnancy_timeline]"
      assert_select "input#profile_label", :name => "profile[label]"
      assert_select "input#profile_weibo", :name => "profile[weibo]"
    end
  end
end
