require 'spec_helper'

describe "work/versions/edit" do
  before(:each) do
    @work_version = assign(:work_version, stub_model(Work::Version))
  end

  it "renders the edit work_version form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => work_versions_path(@work_version), :method => "post" do
    end
  end
end
