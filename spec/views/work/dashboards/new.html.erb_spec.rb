require 'spec_helper'

describe "work/dashboards/new" do
  before(:each) do
    assign(:work_dashboard, stub_model(Work::Dashboard).as_new_record)
  end

  it "renders new work_dashboard form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => work_dashboards_path, :method => "post" do
    end
  end
end
