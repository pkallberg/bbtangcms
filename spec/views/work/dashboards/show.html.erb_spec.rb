require 'spec_helper'

describe "work/dashboards/show" do
  before(:each) do
    @work_dashboard = assign(:work_dashboard, stub_model(Work::Dashboard))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
