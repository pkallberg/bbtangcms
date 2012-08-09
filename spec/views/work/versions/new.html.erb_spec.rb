require 'spec_helper'

describe "work/versions/new" do
  before(:each) do
    assign(:work_version, stub_model(Work::Version).as_new_record)
  end

  it "renders new work_version form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => work_versions_path, :method => "post" do
    end
  end
end
