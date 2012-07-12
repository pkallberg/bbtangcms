require 'spec_helper'

describe "tag/identities/index" do
  before(:each) do
    assign(:tag_identities, [
      stub_model(Tag::Identity,
        :name => "Name",
        :parent_id => 1
      ),
      stub_model(Tag::Identity,
        :name => "Name",
        :parent_id => 1
      )
    ])
  end

  it "renders a list of tag/identities" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
