require 'spec_helper'

describe "tag/timelines/index" do
  before(:each) do
    assign(:tag_timelines, [
      stub_model(Tag::Timeline,
        :name => "Name",
        :parent_id => 1
      ),
      stub_model(Tag::Timeline,
        :name => "Name",
        :parent_id => 1
      )
    ])
  end

  it "renders a list of tag/timelines" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
