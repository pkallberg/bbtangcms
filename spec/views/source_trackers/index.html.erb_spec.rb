require 'spec_helper'

describe "source_trackers/index" do
  before(:each) do
    assign(:source_trackers, [
      stub_model(SourceTracker,
        :key => "Key",
        :platform => "Platform",
        :from => "From",
        :version_number => "Version Number",
        :ip => "Ip",
        :url => "Url"
      ),
      stub_model(SourceTracker,
        :key => "Key",
        :platform => "Platform",
        :from => "From",
        :version_number => "Version Number",
        :ip => "Ip",
        :url => "Url"
      )
    ])
  end

  it "renders a list of source_trackers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "Platform".to_s, :count => 2
    assert_select "tr>td", :text => "From".to_s, :count => 2
    assert_select "tr>td", :text => "Version Number".to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
