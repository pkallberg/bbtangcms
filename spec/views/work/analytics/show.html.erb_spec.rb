require 'spec_helper'

describe "work/analytics/show" do
  before(:each) do
    @work_analytic = assign(:work_analytic, stub_model(Work::Analytic))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
