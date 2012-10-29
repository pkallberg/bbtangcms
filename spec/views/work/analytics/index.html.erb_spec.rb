require 'spec_helper'

describe "work/analytics/index" do
  before(:each) do
    assign(:work_analytics, [
      stub_model(Work::Analytic),
      stub_model(Work::Analytic)
    ])
  end

  it "renders a list of work/analytics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
