require 'spec_helper'

describe "work/user_statistics/new" do
  before(:each) do
    assign(:work_user_statistic, stub_model(Work::UserStatistic).as_new_record)
  end

  it "renders new work_user_statistic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => work_user_statistics_path, :method => "post" do
    end
  end
end
