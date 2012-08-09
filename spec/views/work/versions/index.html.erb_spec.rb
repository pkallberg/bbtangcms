require 'spec_helper'

describe "work/versions/index" do
  before(:each) do
    assign(:work_versions, [
      stub_model(Work::Version),
      stub_model(Work::Version)
    ])
  end

  it "renders a list of work/versions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
