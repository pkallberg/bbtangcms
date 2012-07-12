require 'spec_helper'

describe "tag/identities/show" do
  before(:each) do
    @tag_identity = assign(:tag_identity, stub_model(Tag::Identity,
      :name => "Name",
      :parent_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
