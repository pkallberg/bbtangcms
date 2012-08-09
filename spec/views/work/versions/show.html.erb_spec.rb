require 'spec_helper'

describe "work/versions/show" do
  before(:each) do
    @work_version = assign(:work_version, stub_model(Work::Version))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
