require 'spec_helper'

describe "tag/identities/edit" do
  before(:each) do
    @tag_identity = assign(:tag_identity, stub_model(Tag::Identity,
      :name => "MyString",
      :parent_id => 1
    ))
  end

  it "renders the edit tag_identity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tag_identities_path(@tag_identity), :method => "post" do
      assert_select "input#tag_identity_name", :name => "tag_identity[name]"
      assert_select "input#tag_identity_parent_id", :name => "tag_identity[parent_id]"
    end
  end
end
