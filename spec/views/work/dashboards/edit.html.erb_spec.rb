require 'spec_helper'

describe "work/dashboards/edit" do
  before(:each) do
    @work_dashboard = assign(:work_dashboard, stub_model(Work::Dashboard))
  end

  it "renders the edit work_dashboard form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => work_dashboards_path(@work_dashboard), :method => "post" do
    end
  end
end
