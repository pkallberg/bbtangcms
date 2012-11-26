require 'spec_helper'

describe "source_trackers/show" do
  before(:each) do
    @source_tracker = assign(:source_tracker, stub_model(SourceTracker,
      :key => "Key",
      :platform => "Platform",
      :from => "From",
      :version_number => "Version Number",
      :ip => "Ip",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Key/)
    rendered.should match(/Platform/)
    rendered.should match(/From/)
    rendered.should match(/Version Number/)
    rendered.should match(/Ip/)
    rendered.should match(/Url/)
  end
end
