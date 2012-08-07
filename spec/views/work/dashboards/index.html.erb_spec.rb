require 'spec_helper'

describe "work/dashboards/index" do
  before(:each) do
    assign(:work_dashboards, [
      stub_model(Work::Dashboard),
      stub_model(Work::Dashboard)
    ])
  end

  it "renders a list of work/dashboards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
