require 'spec_helper'

describe "tag/timelines/show" do
  before(:each) do
    @tag_timeline = assign(:tag_timeline, stub_model(Tag::Timeline,
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
