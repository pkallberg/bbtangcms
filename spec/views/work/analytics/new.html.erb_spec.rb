require 'spec_helper'

describe "work/analytics/new" do
  before(:each) do
    assign(:work_analytic, stub_model(Work::Analytic).as_new_record)
  end

  it "renders new work_analytic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => work_analytics_path, :method => "post" do
    end
  end
end
