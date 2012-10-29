require 'spec_helper'

describe "work/analytics/edit" do
  before(:each) do
    @work_analytic = assign(:work_analytic, stub_model(Work::Analytic))
  end

  it "renders the edit work_analytic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => work_analytics_path(@work_analytic), :method => "post" do
    end
  end
end
